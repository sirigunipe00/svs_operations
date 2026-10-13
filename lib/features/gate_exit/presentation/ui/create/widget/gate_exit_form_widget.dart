import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/inputs/image_selection_widget1.dart';
import 'package:svs_operations/widgets/widgets.dart';

class GateExitFormWidget extends StatefulWidget {
  const GateExitFormWidget({super.key});

  @override
  State<GateExitFormWidget> createState() => _GateExitFormWidgetState();
}

class _GateExitFormWidgetState extends State<GateExitFormWidget> {
  @override
  Widget build(BuildContext context) {
    final formState = context.read<CreateGateExitCubit>().state;
    final isCreating = formState.view == GateExitView.create;
    final isCompleted = formState.view == GateExitView.completed;
    final form = formState.form;

    return SpacedColumn(
      defaultHeight: 10,
      margin: const EdgeInsets.all(12.0),
      children: [
        BlocBuilder<CreateGateExitCubit, CreateGateExitState>(
          buildWhen: (pv, curr) =>
              pv.form.salesInvNumber != curr.form.salesInvNumber,
          builder: (_, state) => InputField(
            title: 'Sales Invoice Number',
            initialValue: state.form.salesInvNumber,
            // readOnly: true,
            isRequired: true,
            suffixIcon: IconButton(
              onPressed: isCompleted ? null : () => onScan(context),
              icon: const Icon(Icons.document_scanner_outlined,
                  color: AppColors.chimneySweep),
            ),
            borderColor: AppColors.lavender,
            onChanged: (text) {
              context
                  .cubit<CreateGateExitCubit>()
                  .onFieldChange(salesInvNo: text);

              unawaited(context.cubit<GetVehicleNumber>().request(text));
            },
          ),
        ),
        BlocConsumer<GetVehicleNumber, GetVehicleNumberState>(
          listener: (_, state) {
            state.maybeWhen(
              orElse: () {},
              success: (data) {
                context
                    .cubit<CreateGateExitCubit>()
                    .onFieldChange(vehicleNo: data);
                setState(() {});
              },
            );
          },
          builder: (_, state) {
            return InputField(
              title: 'Vechicle Number',
              readOnly: isCompleted,
              isRequired: true,
              suffixIcon: state.isLoading
                  ? const CupertinoActivityIndicator()
                  : const SizedBox.shrink(),
              inputFormatters: [UpperCaseTextFormatter()],
              initialValue: form.vehicleNo,
              borderColor: AppColors.lavender,
              onChanged: (text) {
                context
                    .cubit<CreateGateExitCubit>()
                    .onFieldChange(vehicleNo: text);
              },
            );
          },
        ),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<CreateGateExitCubit, CreateGateExitState>(
                buildWhen: (pv, curr) =>
                    (pv.form.vehiclePhoto != curr.form.vehiclePhoto),
                builder: (_, state) => ImageSelectionWidget1(
                  title: 'Vechicle Front Photo',
                  borderColor: AppColors.lavender,
                  readOnly: isCompleted,
                  defaultVal: state.form.vehiclePhoto,
                  placeholder: const Icon(Icons.local_shipping,
                      size: 64, color: AppColors.chimneySweep),
                  onView: () {
                    final data = Pair(form.name ?? 'Vehicle Front Photo',
                        state.form.vehiclePhoto);
                    AppRoute.newGateExitPreview.push(context, extra: data);
                  },
                  onImage: (file) {
                    if (file.isNull) {
                      context.cubit<CreateGateExitCubit>().clearVehiclePhoto();
                    } else {
                      context
                          .cubit<CreateGateExitCubit>()
                          .onFieldChange(vehiclePhoto: file);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: BlocBuilder<CreateGateExitCubit, CreateGateExitState>(
                buildWhen: (pv, curr) =>
                    (pv.form.vehicleBackPhoto != curr.form.vehicleBackPhoto),
                builder: (_, state) => ImageSelectionWidget1(
                  title: 'Vechicle Back Photo',
                  borderColor: AppColors.lavender,
                  readOnly: isCompleted,
                  defaultVal: state.form.vehicleBackPhoto,
                  placeholder: const Icon(Icons.local_shipping,
                      size: 64, color: AppColors.chimneySweep),
                  onView: () {
                    final data = Pair(form.name ?? 'Vehicle Photo',
                        state.form.vehicleBackPhoto);
                    AppRoute.newGateExitPreview.push(context, extra: data);
                  },
                  onImage: (file) {
                    if (file.isNull) {
                      context
                          .cubit<CreateGateExitCubit>()
                          .clearVehicleBackPhoto();
                    } else {
                      context
                          .cubit<CreateGateExitCubit>()
                          .onFieldChange(vehicleBackPhoto: file);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
        DateSelectionField(
          title: 'Gate Exit Date',
          initialValue: form.exitDate,
          firstDate: DFU.now(),
          lastDate: DFU.now(),
          onDateSelect: (date) {},
          readOnly: true,
          filled: true,
          borderColor: AppColors.lavender,
          suffixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.black,
          ),
        ),
        InputField(
          title: 'Remarks',
          readOnly: isCompleted,
          initialValue: form.remarks,
          borderColor: AppColors.lavender,
          minLines: 3,
          onChanged: (text) {
            context.cubit<CreateGateExitCubit>().onFieldChange(remarks: text);
          },
        ),
        if (!isCompleted) ...[
          BlocBuilder<CreateGateExitCubit, CreateGateExitState>(
            buildWhen: (pv, curr) => pv.isLoading != curr.isLoading,
            builder: (_, state) => AppButton(
              label: isCreating ? 'Save' : 'Submit',
              isLoading: state.isLoading,
              bgColor: AppColors.haintBlue,
              margin: const EdgeInsets.all(12.0),
              onPressed: context.cubit<CreateGateExitCubit>().save,
            ),
          ),
        ],
      ],
    );
  }

  void onScan(BuildContext context) async {
    String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      scanType: ScanType.barcode,
      cameraFace: CameraFace.back,
    );
    final isValidValue =
        barcodeScanRes.containsValidValue && barcodeScanRes != '-1';
    if (!context.mounted) return;
    if (isValidValue) {
      context
          .cubit<CreateGateExitCubit>()
          .onFieldChange(salesInvNo: barcodeScanRes);
      unawaited(context.cubit<GetVehicleNumber>().request(barcodeScanRes));
    }
  }
}
