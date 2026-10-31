import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/data/gate_entry_repo.dart';
import 'package:svs_operations/features/gate_entry/model/gate_entry.dart';
import 'package:svs_operations/features/gate_entry/model/new_gate_entry_form.dart';

part 'new_gate_entry_cubit.freezed.dart';

enum GateEntryView { create, edit, completed }

@injectable
class NewGateEntryCubit extends AppBaseCubit<NewGateEntryState> {
  NewGateEntryCubit(this.repo) : super(NewGateEntryState.initial());

  final GateEntryRepo repo;

  Future<void> onValueChanged({
    String? poNumber,
    String? vehicleNo,
    String? vendorInvNo,
    String? vendorname,
    String? invoiceDate,
    String? invoiceQty,
    String? invoiceAmt,
    String? remarks,
    File? invoicePhoto,
    File? vehiclePhoto,
    File? vehicleBackPhoto,
    int? isJobWork,
  }) async {
    final form = state.form;
    final vendorInvPhoto = invoicePhoto.isNull
        ? form.vendorInvPhoto
        : await ImageCompressUtil.compressFileToBase64(invoicePhoto!);
    final vehPhoto = vehiclePhoto.isNull
        ? form.vehiclePhoto
        : await ImageCompressUtil.compressFileToBase64(vehiclePhoto!);
    final vehbackPhoto = vehicleBackPhoto.isNull
        ? form.vehicleBackPhoto
        : await ImageCompressUtil.compressFileToBase64(vehicleBackPhoto!);

    final newForm = form.copyWith(
      isJobWork: isJobWork ?? form.isJobWork,
      poNumber: poNumber ?? form.poNumber,
      vehicleNo: vehicleNo ?? form.vehicleNo,
      vendorInvNo: vendorInvNo ?? form.vendorInvNo,
      invoiceDate: invoiceDate ?? form.invoiceDate,
      invoiceQty: invoiceQty ?? form.invoiceQty,
      vendorInvPhoto: vendorInvPhoto,
      vehiclePhoto: vehPhoto,
      invoiceAmt: invoiceAmt ?? form.invoiceAmt,
      remarks: remarks ?? form.remarks,
      vehicleBackPhoto: vehbackPhoto,
      vendorName: vendorname ?? form.vendorName
    );
    emitSafeState(state.copyWith(form: newForm));
  }

  void initDetails(GateEntry? entry) {
    if (entry == null) return;
    final form = state.form;
    final updatedform = form.copyWith(
      name: entry.name,
      status: entry.status,
      entryDate: entry.entryDate,
      invoiceAmt: entry.invoiceAmt?.toString(),
      invoiceDate: entry.invoiceDate,
      invoiceQty: entry.invoiceQty?.toString(),
      poNumber: entry.poNumber,
      vehicleNo: entry.vehicleNo,
      vendorInvNo: entry.vendorInvNo,
      vendorName: entry.vendorName,
      vehiclePhoto: entry.vehiclePhoto,
      vendorInvPhoto: entry.invoicePhoto,
      vehicleBackPhoto: entry.vehicleBackPhoto,
      remarks: entry.remarks,
      isJobWork: entry.isJobWork,
    );

    final isSubmitted =
        StringUtils.equalsIgnoreCase(entry.status?.trim(), 'Submitted');
    final isCancelled =
        StringUtils.equalsIgnoreCase(entry.status?.trim(), 'Cancelled');
    final mode = (isSubmitted || isCancelled)
        ? GateEntryView.completed
        : GateEntryView.edit;
    emitSafeState(state.copyWith(form: updatedform, view: mode));
  }

  void clearVehiclePhoto() {
    final form = state.form.copyWith(vehiclePhoto: null);
    emitSafeState(state.copyWith(form: form));
  }

  void clearVehicleBackPhoto() {
    final form = state.form.copyWith(vehicleBackPhoto: null);
    emitSafeState(state.copyWith(form: form));
  }

  void clearInvPhoto() {
    final form = state.form.copyWith(vendorInvPhoto: null);
    emitSafeState(state.copyWith(form: form));
  }

  void save() async {
    final validation = _validate();
    return validation.fold(
      () async {
        emitSafeState(state.copyWith(isLoading: true, isSuccess: false));
        final nextMode = switch (state.view) {
          GateEntryView.create => GateEntryView.edit,
          GateEntryView.edit ||
          GateEntryView.completed =>
            GateEntryView.completed,
        };

        final status = switch (state.view) {
          GateEntryView.create => 'Draft',
          GateEntryView.edit || GateEntryView.completed => 'Submitted',
        };

        var formToSubmit = state.form;
        if (formToSubmit.vendorInvPhoto != null) {
          final cmp = await ImageCompressUtil.compressBase64Image(
              formToSubmit.vendorInvPhoto!);
          formToSubmit = formToSubmit.copyWith(vendorInvPhoto: cmp);
        }
        if (formToSubmit.vehiclePhoto != null) {
          final cmp = await ImageCompressUtil.compressBase64Image(
              formToSubmit.vehiclePhoto!);
          formToSubmit = formToSubmit.copyWith(vehiclePhoto: cmp);
        }
        if (formToSubmit.vehicleBackPhoto != null) {
          final cmp = await ImageCompressUtil.compressBase64Image(
              formToSubmit.vehicleBackPhoto!);
          formToSubmit = formToSubmit.copyWith(vehicleBackPhoto: cmp);
        }

        final response = state.view == GateEntryView.create
            ? await repo.createGateEntry(formToSubmit)
            : await repo.submitGateEntry(formToSubmit);
        return response.fold(
          (l) => emitSafeState(state.copyWith(isLoading: false, error: l)),
          (r) => emitSafeState(state.copyWith(
            isLoading: false,
            isSuccess: true,
            form: state.form.copyWith(name: r.first, status: status),
            successMsg: r.second,
            view: nextMode,
          )),
        );
      },
      _emitError,
    );
  }

  void _emitError(String error) {
    final failure = Failure(error: error, title: 'Missing Fields');
    emitSafeState(state.copyWith(error: failure, isLoading: false));
  }

  void errorHandled() {
    emitSafeState(state.copyWith(error: null, isLoading: false));
  }

  Option<String> _validate() {
    final form = state.form;
    if (form.vehicleNo.doesNotHaveValue) {
      return optionOf('Enter Vehcile Number');
    } else if (form.poNumber.doesNotHaveValue) {
      return optionOf('Enter Purchase Order Document No.');
    } else if (form.vendorInvNo.doesNotHaveValue) {
      return optionOf('Enter Vendor Invoice No.');
    } else if (form.invoiceDate.doesNotHaveValue) {
      return optionOf('Enter Vendor Invoice Date');
    } else if (form.vehiclePhoto.doesNotHaveValue) {
      return optionOf('Capture Vehicle Photo');
    }  else if (form.vehicleBackPhoto.doesNotHaveValue) {
      return optionOf('Capture Vehicle Back Photo');
    } else if (form.vendorInvPhoto.doesNotHaveValue) {
      return optionOf('Capture Vendor Invoice');
    }
    return const None();
  }
}

@freezed
class NewGateEntryState with _$NewGateEntryState {
  const factory NewGateEntryState({
    required NewGateEntryForm form,
    required bool isLoading,
    required bool isSuccess,
    required GateEntryView view,
    Failure? error,
    String? successMsg,
  }) = _NewGateEntryState;

  factory NewGateEntryState.initial() {
    return NewGateEntryState(
      form: NewGateEntryForm(entryDate: DFU.friendlyFormat(DateTime.now())),
      view: GateEntryView.create,
      isLoading: false,
      isSuccess: false,
    );
  }
}
