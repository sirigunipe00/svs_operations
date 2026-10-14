import 'dart:io';

import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:path_provider/path_provider.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/create_item_cubit.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/screens/qr_scanner_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/rejection_tray_widget.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class TubeCuttingWorkStationScreen extends StatefulWidget {
  final String title;
  final OperationScanModel operationStatus;
  final WorkOrderItem workOrder;
  final String scanMachine;
  final String scanTray;
  final ChildStatusModel childItem;
  final bool inProgress;
  final String selectedfilter;

  const TubeCuttingWorkStationScreen({
    super.key,
    required this.title,
    required this.operationStatus,
    required this.workOrder,
    required this.scanMachine,
    required this.scanTray,
    required this.childItem,
    required this.inProgress, required this.selectedfilter,
  });

  @override
  State<TubeCuttingWorkStationScreen> createState() =>
      _TubeCuttingWorkStationScreenState();
}

class _TubeCuttingWorkStationScreenState
    extends State<TubeCuttingWorkStationScreen> {
  String? selectedItem;
  String? startImage;
  String? endImage;
  String? binQrCode;
  String? outputtray;
  String? rejectionTrayImagePath;

  final TextEditingController itemCountController = TextEditingController();

  int selectedBottomIndex = 0;
  int? selectedItemCount;

  @override
  void initState() {
    super.initState();

    context.read<CreateItemCubit>().onValueChanged(
        workOrder: widget.workOrder.workOrder,
        jobCard: widget.workOrder.name,
        employee: context.user.email,
        operation: widget.title,
        childId: widget.childItem.name);
  }

  @override
  void dispose() {
    itemCountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.operationStatus.isCounterScan == 1) ...[
            _buildMachineCounterSection(),
            const SizedBox(height: 8),
            _buildItemCount(),
          ],
          if (widget.title == 'Tube Cutting' && !widget.inProgress) ...[
            const SizedBox(height: 10),
            _buildItemCountDropdown(),
          ],
          if (widget.inProgress && widget.operationStatus.isRejection == 1) ...[
            const SizedBox(height: 10),
            RejectionTrayWidget(
              onScanTap: scanRejectionTray,
              onCameraTap: captureRejectionTrayImage,
              trayId: binQrCode ?? 'XXX-XX-XX-XXX',
              rejectionTrayImagePath: rejectionTrayImagePath ?? '',
            ),
          ],
          const SizedBox(height: 20),
          _buildSubmitButton(),
        ],
      ),
    );
  }

  Future<void> scanRejectionTray() async {
    // final String? scannedValue = 'A008';
    final String? scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );
    setState(() {
      // binQrCode = 'A008';
      binQrCode = scannedValue;
      context.read<CreateItemCubit>().onValueChanged(rejectiontray: binQrCode);
    });
  }

  Future<void> captureRejectionTrayImage() async {
    final picker = ImagePicker();

    final XFile? photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo == null) return;

    final directory = await getApplicationDocumentsDirectory();

    final savedImage = await File(photo.path).copy(
      '${directory.path}/rejection_tray_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );

    if (!mounted) return;

    setState(() {
      rejectionTrayImagePath = savedImage.path;
      context
          .read<CreateItemCubit>()
          .onValueChanged(rejectionImage: File(rejectionTrayImagePath ?? ''));
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Rejection tray image saved')),
    );
  }

  Widget _buildMachineCounterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'MACHINE COUNTER PHOTO',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF85888D),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: _buildPhotoCard(
                enable: !widget.inProgress,
                title: 'Start Image',
                imagePath: widget.childItem.startImage != null &&
                        widget.childItem.startImage!.isNotEmpty
                    ? widget.childItem.startImage
                    : startImage,
                isNetworkImage: widget.childItem.startImage != null &&
                    widget.childItem.startImage!.isNotEmpty,
                onTap: () => _captureImage(isStart: true),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: _buildPhotoCard(
                enable: widget.inProgress,
                imagePath: widget.childItem.endImage != null &&
                        widget.childItem.endImage!.isNotEmpty
                    ? widget.childItem.endImage
                    : endImage,
                isNetworkImage: widget.childItem.endImage != null &&
                    widget.childItem.endImage!.isNotEmpty,
                title: 'End Image',
                onTap: () => _captureImage(isStart: false),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhotoCard({
    required String title,
    required String? imagePath,
    required VoidCallback onTap,
    required bool isNetworkImage,
    required bool enable,
  }) {
    const baseUrl = 'https://svserpnextuat.easycloud.co.in';
    print('url..:$baseUrl$imagePath');
    return InkWell(
      onTap: enable ? onTap : null,
      borderRadius: BorderRadius.circular(17),
      child: Container(
        height: 140,
        width: 193,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD5D5D5),
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath == null || imagePath.isEmpty)
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFF1F2F7),
                ),
                child: const Icon(
                  Icons.camera_alt_outlined,
                  size: 20,
                  color: Color(0xFF087EFF),
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: isNetworkImage
                    ? Image.network(
                        '$baseUrl$imagePath',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      )
                    : Image.file(
                        File(imagePath),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
              ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: AppColors.blue,
              ),
            ),
            const SizedBox(height: 3),
            if (enable) ...[
              Text(
                'Tap to capture',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF929297),
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _captureImage({
    required bool isStart,
  }) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      setState(() {
        if (isStart) {
          startImage = image.path;
          context
              .read<CreateItemCubit>()
              .onValueChanged(startImage: File(startImage ?? ''));
        } else {
          endImage = image.path;

          context
              .read<CreateItemCubit>()
              .onValueChanged(endImage: File(endImage ?? ''));
        }
      });
    }
  }

  Widget _buildItemCount() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.blue.shade200,
          width: 0.5,
        ),
      ),
      child: TextField(
        controller: itemCountController,
        onChanged: (value) {
          print('value..:$value');
          context.cubit<CreateItemCubit>().onValueChanged(
                startReading: int.tryParse(value),
              );
        },
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF168FD2),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14,
          ),
          hintText: 'Item Count',
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF168FD2),
          ),
          suffixText: 'Pcs.',
          suffixStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Color(0xFF168FD2),
          ),
        ),
      ),
    );
  }

  Widget _buildItemCountDropdown() {
    return DropdownButtonFormField<int>(
      value: selectedItemCount,
      isExpanded: true,
      alignment: Alignment.centerLeft,
      decoration: InputDecoration(
        hintText: 'Select item count',
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFF687A96),
          ),
        ),
      ),
      hint: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Select item count',
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF777777),
          ),
        ),
      ),
      items: [1, 2, 3, 4].map((count) {
        return DropdownMenuItem<int>(
          value: count,
          child: Text('$count'),
        );
      }).toList(),
      onChanged: (value) {
        if (value == null) return;

        setState(() {
          selectedItemCount = value;
        });

        context.read<CreateItemCubit>().onValueChanged(
              cutQty: value,
            );
      },
    );
  }

  Widget _buildSubmitButton() {
    startImage != null && endImage != null && binQrCode != null;

    return SizedBox(
        width: double.infinity,
        height: 50,
        child: BlocConsumer<CreateItemCubit, CreateItemState>(
          listener: (context, state) async {
            if (state.error.isNotNull) {
              await AppDialog.showErrorDialog(
                context,
                title: state.error!.title,
                content: state.error!.error,
                onTapDismiss: context.exit,
              );
              if (!context.mounted) return;
              context.cubit<CreateItemCubit>().errorHandled();
              return;
            } else if (state.successMsg != null) {
              AppDialog.showSuccessDialog(
                context,
                content: state.successMsg!,
                onTapDismiss: context.exit,
              ).then(
                (_) {
                  if (context.mounted) {
                    print('successss...........');
                    context
                      ..cubit<WorkOrderList>().request(dartz.Tuple3(widget.title, '', 'All'))
                      ..cubit<CreateItemCubit>().errorHandled();
                    setState(() {
                      print('SETSTAAE..........');
                    });

                    Navigator.of(context).pop();
                  }
                },
              );
            }
          },
          builder: (context, state) {
            return ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      if (widget.inProgress) {
                        _handleUpdateOperation();
                      } else {
                        context.read<CreateItemCubit>().save(widget.inProgress);
                      }
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: state.isLoading
                  ? const LoadingIndicator()
                  : Text(
                      widget.inProgress ? 'Complete Operation' : 'Start Operation',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            );
          },
        ));
  }

  Future<void> _handleUpdateOperation() async {
    // Step 1: Open QR scanner.
    // final scannedValue = 'A009';

    final String? scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => const QrScannerScreen(),
      ),
    );

    if (!mounted || scannedValue == null) return;

    // Step 2: Store the scanned QR value.
    setState(() {
      outputtray = scannedValue;
      context.read<CreateItemCubit>().onValueChanged(outputTray: outputtray);
    });

    // Step 3: Show success dialog with Submit button.
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 48,
          ),
          title: const Text('QR Scan Successful'),
          content: Text(
            'QR code scanned successfully.\n\n'
            'Scanned ID: $scannedValue',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<CreateItemCubit>().save(widget.inProgress);
              },
              child: const Text('Submit'),
            ),
          ],
        );
      },
    );
  }
}
