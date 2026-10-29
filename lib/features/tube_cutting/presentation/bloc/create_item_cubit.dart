import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/cubit/base/base_cubit.dart';
import 'package:svs_operations/core/model/failure.dart';
import 'package:svs_operations/core/utils/date_format_util.dart';
import 'package:svs_operations/core/utils/string_utils.dart';
import 'package:svs_operations/features/gate_entry/data/gate_entry_repo.dart';
import 'package:svs_operations/features/gate_entry/model/gate_entry.dart';
import 'package:svs_operations/features/gate_entry/model/new_gate_entry_form.dart';
import 'package:svs_operations/features/tube_cutting/data/tube_cutting_repo.dart';
import 'package:svs_operations/features/tube_cutting/model/add_item_model.dart';

part 'create_item_cubit.freezed.dart';

enum AddItemView { create, update, completed }

@injectable
class CreateItemCubit extends AppBaseCubit<CreateItemState> {
  CreateItemCubit(this.repo) : super(CreateItemState.initial());

  final TubeCuttingRepo repo;

  void onValueChanged({
    String? jobCard,
    String? workOrder,
    String? operation,
    String? employee,
    String? machine,
    String? inputTray,
    String? outputTray,
    String? childId,
    File? startImage,
    File? endImage,
    File? rejectionImage,
    int? startReading,
    int? endReading,
    int? rejectedQty,
    int? cutQty,
    String? rejectiontray,
    double? scrapKgs,
  }) {
    final form = state.form;
    final startImg = startImage.isNull
        ? form.startImage
        : base64Encode(startImage!.readAsBytesSync());
    final endImg = endImage.isNull
        ? form.endImage
        : base64Encode(endImage!.readAsBytesSync());

    final rejectimg = rejectionImage.isNull
        ? form.rejectionTrayImage
        : base64Encode(rejectionImage!.readAsBytesSync());

    final newForm = form.copyWith(
        jobCard: jobCard ?? form.jobCard,
        childId: childId ?? form.childId,
        employee: employee ?? form.employee,
        endReadings: endReading ?? form.endReadings,
        inputTray: inputTray ?? form.inputTray,
        machine: machine ?? form.machine,
        operation: operation ?? form.operation,
        outputTray: outputTray ?? form.outputTray,
        startReadings: startReading ?? form.startReadings,
        workOrder: workOrder ?? form.workOrder,
        endImage: endImg ?? form.endImage,
        startImage: startImg ?? form.startImage,
        rejectionCounter: rejectedQty ?? form.rejectionCounter,
        cutQnty: cutQty ?? form.cutQnty,
        rejectionTrayImage: rejectimg ?? form.rejectionTrayImage,
        rejectionTray: rejectiontray ?? form.rejectionTray,
        scrapKgs: scrapKgs ?? form.scrapKgs,
        );
      
    emitSafeState(state.copyWith(form: newForm));
  }

  void initDetails(GateEntry? entry) {
    if (entry == null) return;
    final form = state.form;
    final updatedform = form.copyWith();

    final isSubmitted =
        StringUtils.equalsIgnoreCase(entry.status?.trim(), 'Submitted');
    final isCancelled =
        StringUtils.equalsIgnoreCase(entry.status?.trim(), 'Cancelled');
    final mode = (isSubmitted || isCancelled)
        ? AddItemView.completed
        : AddItemView.update;
    emitSafeState(state.copyWith(form: updatedform, view: mode));
  }

  void clearStartPhoto() {
    final form = state.form.copyWith(startImage: null);
    emitSafeState(state.copyWith(form: form));
  }

  void clearEndPhoto() {
    final form = state.form.copyWith(endImage: null);
    emitSafeState(state.copyWith(form: form));
  }

  

  void save(bool isInProgress) async {
    emitSafeState(state.copyWith(isLoading: true, isSuccess: false));
    final nextMode = switch (state.view) {
      AddItemView.create => AddItemView.update,
      AddItemView.update || AddItemView.completed => AddItemView.completed,
    };

    // final status = switch (state.view) {
    //   AddItemView.create => 'Draft',
    //   AddItemView.update || AddItemView.completed => 'Submitted',
    // };

    final response = !isInProgress
        ? await repo.createItem(state.form)
        : await repo.updateItem(state.form);
    return response.fold(
      (l) => emitSafeState(state.copyWith(isLoading: false, error: l)),
      (r) => emitSafeState(state.copyWith(
        isLoading: false,
        isSuccess: true,
        form: state.form,
        successMsg: r,
        view: nextMode,
      )),
    );
  }

  void _emitError(String error) {
    final failure = Failure(error: error, title: 'Missing Fields');
    emitSafeState(state.copyWith(error: failure, isLoading: false));
  }

  void errorHandled() {
    emitSafeState(state.copyWith(error: null, isLoading: false));
  }

  // Option<String> _validate() {
  //   final form = state.form;
  //   if (form.poNumber.doesNotHaveValue) {
  //     return optionOf('Enter Purchase Order Document No.');
  //   } else if (form.vehicleNo.doesNotHaveValue) {
  //     return optionOf('Enter Vehcile Number');
  //   } else if (form.vehiclePhoto.doesNotHaveValue) {
  //     return optionOf('Capture Vehicle Photo');
  //   } else if (form.vehicleBackPhoto.doesNotHaveValue) {
  //     return optionOf('Capture Vehicle Back Photo');
  //   } else if (form.vendorInvPhoto.doesNotHaveValue) {
  //     return optionOf('Capture Vendor Invoice');
  //   } else if (form.vendorInvNo.doesNotHaveValue) {
  //     return optionOf('Enter Vendor Invoice No.');
  //   } else if (form.invoiceDate.doesNotHaveValue) {
  //     return optionOf('Enter Vendor Invoice Date');
  //   }
  //   return const None();
  // }
}

@freezed
class CreateItemState with _$CreateItemState {
  const factory CreateItemState({
    required AddItemModel form,
    required bool isLoading,
    required bool isSuccess,
    required AddItemView view,
    Failure? error,
    String? successMsg,
  }) = _CreateItemState;

  factory CreateItemState.initial() {
    return const CreateItemState(
      form: AddItemModel(),
      view: AddItemView.create,
      isLoading: false,
      isSuccess: false,
    );
  }
}
