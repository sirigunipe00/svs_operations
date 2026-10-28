import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart';

class GateExitFormWidget extends StatefulWidget {
  const GateExitFormWidget({super.key});

  @override
  State<GateExitFormWidget> createState() => _GateExitFormWidgetState();
}

class _GateExitFormWidgetState extends State<GateExitFormWidget> {
  late final TextEditingController _salesInvoiceController;
  late final TextEditingController _vehicleNoController;
  late final TextEditingController _remarksController;

  @override
  void initState() {
    super.initState();
    final form = context.read<CreateGateExitCubit>().state.form;
    _salesInvoiceController =
        TextEditingController(text: form.salesInvNumber ?? '');
    _vehicleNoController = TextEditingController(text: form.vehicleNo ?? '');
    _remarksController = TextEditingController(text: form.remarks ?? '');
  }

  @override
  void dispose() {
    _salesInvoiceController.dispose();
    _vehicleNoController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = context.watch<CreateGateExitCubit>().state;
    final isCompleted = formState.view == GateExitView.completed;
    final form = formState.form;

    // Sync controllers if form state changed from outside (e.g. initDetails)
    if (form.salesInvNumber != null &&
        form.salesInvNumber != _salesInvoiceController.text) {
      _salesInvoiceController.text = form.salesInvNumber!;
    }
    if (form.vehicleNo != null &&
        form.vehicleNo != _vehicleNoController.text) {
      _vehicleNoController.text = form.vehicleNo!;
    }
    if (form.remarks != null &&
        form.remarks != _remarksController.text) {
      _remarksController.text = form.remarks!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CARD 1: VEHICLE
          GateSectionCard(
            number: '1',
            title: 'Vehicle',
            children: [
              GateInputField(
                label: 'Sales Invoice',
                hintText: 'Select sales invoice',
                isRequired: true,
                controller: _salesInvoiceController,
                readOnly: isCompleted,
                prefixIcon: const Icon(
                  Icons.receipt_long_outlined,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: isCompleted ? null : () => onScan(context),
                  icon: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Color(0xFF0284C7),
                    size: 22,
                  ),
                  tooltip: 'Scan Barcode',
                ),
                onChanged: (text) {
                  context
                      .cubit<CreateGateExitCubit>()
                      .onFieldChange(salesInvNo: text);
                  unawaited(context.cubit<GetVehicleNumber>().request(text));
                },
              ),
              // Vehicle Number (Auto-filled from invoice)
              BlocConsumer<GetVehicleNumber, GetVehicleNumberState>(
                listener: (_, state) {
                  state.maybeWhen(
                    orElse: () {},
                    success: (data) {
                      _vehicleNoController.text = data ?? '';
                      context
                          .cubit<CreateGateExitCubit>()
                          .onFieldChange(vehicleNo: data);
                      setState(() {});
                    },
                  );
                },
                builder: (_, state) {
                  return GateInputField(
                    label: 'Vehicle Number',
                    hintText: 'Auto-filled from invoice',
                    controller: _vehicleNoController,
                    isRequired: true,
                    readOnly: isCompleted,
                    inputFormatters: [UpperCaseTextFormatter()],
                    prefixIcon: const Icon(
                      Icons.local_shipping_outlined,
                      color: Color(0xFF94A3B8),
                      size: 20,
                    ),
                    suffixIcon: state.isLoading
                        ? const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: CupertinoActivityIndicator(),
                          )
                        : null,
                    onChanged: (text) {
                      context
                          .cubit<CreateGateExitCubit>()
                          .onFieldChange(vehicleNo: text);
                    },
                  );
                },
              ),

              // Gate Exit Date
              GateDatePickerField(
                label: 'Gate Exit Date',
                initialValue: form.exitDate,
                readOnly: true,
                isRequired: true,
                onDateSelected: (_) {},
              ),
            ],
          ),

          // CARD 3: PHOTOS & REMARKS
          GateSectionCard(
            number: '3',
            title: 'Photos & remarks',
            children: [
              // Vehicle Exit Photo
              GatePhotoPickerBox(
                title: 'Capture vehicle exit photo',
                readOnly: isCompleted,
                imageValue: form.vehiclePhoto,
                onView: () {
                  final data = Pair(
                    form.name ?? 'Vehicle Exit Photo',
                    form.vehiclePhoto,
                  );
                  AppRoute.newGateExitPreview.push(context, extra: data);
                },
                onImage: (file) {
                  if (file == null) {
                    context.cubit<CreateGateExitCubit>().clearVehiclePhoto();
                  } else {
                    context
                        .cubit<CreateGateExitCubit>()
                        .onFieldChange(vehiclePhoto: file);
                  }
                },
              ),

              // Vehicle Back Photo
              GatePhotoPickerBox(
                title: 'Capture vehicle back photo',
                readOnly: isCompleted,
                imageValue: form.vehicleBackPhoto,
                onView: () {
                  final data = Pair(
                    form.name ?? 'Vehicle Back Photo',
                    form.vehicleBackPhoto,
                  );
                  AppRoute.newGateExitPreview.push(context, extra: data);
                },
                onImage: (file) {
                  if (file == null) {
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

              // Remarks
              GateInputField(
                label: 'Remarks',
                hintText: 'Add remarks (optional)',
                controller: _remarksController,
                readOnly: isCompleted,
                minLines: 3,
                maxLines: 4,
                prefixIcon: const Icon(
                  Icons.notes_rounded,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onChanged: (text) {
                  context
                      .cubit<CreateGateExitCubit>()
                      .onFieldChange(remarks: text);
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void onScan(BuildContext context) async {
    final barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scan Sales Invoice',
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
      _salesInvoiceController.text = barcodeScanRes ??'';
      context
          .cubit<CreateGateExitCubit>()
          .onFieldChange(salesInvNo: barcodeScanRes);
      unawaited(context.cubit<GetVehicleNumber>().request(barcodeScanRes));
    }
  }
}
