import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_exit/data/gate_exit_repo.dart';
import 'package:svs_operations/features/gate_exit/model/gate_exit.dart';
import 'package:svs_operations/features/gate_exit/model/new_gate_exit_form.dart';

part 'create_gate_exit_cubit.freezed.dart';

enum GateExitView { create, edit, completed }

@injectable
class CreateGateExitCubit extends AppBaseCubit<CreateGateExitState> {
  CreateGateExitCubit(this.repo) : super(CreateGateExitState.initial());

  final GateExitRepo repo;

  void initDetails(GateExit? gateExit) {
    if (gateExit == null) return;
    final form = state.form;
    final updatedForm = form.copyWith(
      exitDate: gateExit.exitDate,
      status: gateExit.status,
      name: gateExit.name,
      remarks: gateExit.remarks,
      salesInvNumber: gateExit.salesInvNo,
      vehicleNo: gateExit.vehicleNo,
      vehiclePhoto: gateExit.vehiclePhoto,
      vehicleBackPhoto: gateExit.vehicleBackPhoto,
    );

    final isSubmitted =
        StringUtils.equalsIgnoreCase(gateExit.status?.trim(), 'Submitted');
    final isCancelled =
        StringUtils.equalsIgnoreCase(gateExit.status?.trim(), 'Cancelled');
    final mode = (isSubmitted || isCancelled)
        ? GateExitView.completed
        : GateExitView.edit;
    emitSafeState(state.copyWith(form: updatedForm, view: mode));
  }

  Future<void> onFieldChange({
    String? salesInvNo,
    String? vehicleNo,
    String? remarks,
    File? vehiclePhoto,
    File? vehicleBackPhoto,
  }) async {
    final form = state.form;
    final vehPhoto = vehiclePhoto.isNull
        ? form.vehiclePhoto
        : await ImageCompressUtil.compressFileToBase64(vehiclePhoto!);
    final vehBackPhoto = vehicleBackPhoto.isNull
        ? form.vehicleBackPhoto
        : await ImageCompressUtil.compressFileToBase64(vehicleBackPhoto!);
    final updatedForm = form.copyWith(
      name: form.name ,
      exitDate: form.exitDate,
      salesInvNumber: salesInvNo ?? form.salesInvNumber,
      vehicleNo: vehicleNo ?? form.vehicleNo,
      vehiclePhoto: vehPhoto ?? form.vehiclePhoto,
      remarks: remarks ?? form.remarks,
      vehicleBackPhoto: vehBackPhoto ?? form.vehicleBackPhoto,
    );
    emitSafeState(state.copyWith(form: updatedForm));
  }

  void clearVehiclePhoto() {
    final form = state.form.copyWith(vehiclePhoto: null);
    emitSafeState(state.copyWith(form: form));
  }
   void clearVehicleBackPhoto() {
    final form = state.form.copyWith(vehicleBackPhoto: null);
    emitSafeState(state.copyWith(form: form));
  }

  void save() async {
    final validation = _validate();
    return validation.fold(
      () async {
        emitSafeState(state.copyWith(isLoading: true, isSuccess: false));

        final nextMode = switch (state.view) {
          GateExitView.create => GateExitView.edit,
          GateExitView.edit || GateExitView.completed => GateExitView.completed,
        };

        final status = switch (state.view) {
          GateExitView.create => 'Draft',
          GateExitView.edit || GateExitView.completed => 'Submitted',
        };

        var formToSubmit = state.form;
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

        final response = state.view == GateExitView.create
            ? await repo.createGateExit(formToSubmit)
            : await repo.submitGateExit(formToSubmit);
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
      return optionOf('Enter Vehicle Number.');
    } else if (form.salesInvNumber.doesNotHaveValue) {
      return optionOf('Scan Sales Invoice Document No.');
    } else if (form.vehiclePhoto.doesNotHaveValue) {
      return optionOf('Capture Vehicle Front Photo.');
    } else if (form.vehicleBackPhoto.doesNotHaveValue) {
      return optionOf('Capture Vehicle Back Photo.');
    } 
    return const None();
  }
}

@freezed
class CreateGateExitState with _$CreateGateExitState {
  const factory CreateGateExitState({
    required NewGateExitForm form,
    required bool isLoading,
    required bool isSuccess,
    required GateExitView view,
    Failure? error,
    String? successMsg,
  }) = _CreateGateExitState;

  factory CreateGateExitState.initial() {
    return CreateGateExitState(
      form: NewGateExitForm(exitDate: DFU.friendlyFormat(DateTime.now())),
      view: GateExitView.create,
      isLoading: false,
      isSuccess: false,
    );
  }
}
