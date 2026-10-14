import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/create_item_cubit.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/screens/qr_scanner_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/dashed_border_box.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class TubeCuttingScreen extends StatefulWidget {
  final String title;
  final String selectedFilter;
  final WorkOrderItem workOrder;

  const TubeCuttingScreen({
    super.key,
    required this.title,
    required this.workOrder,
    required this.selectedFilter,
  });

  @override
  State<TubeCuttingScreen> createState() => _TubeCuttingScreenState();
}

class _TubeCuttingScreenState extends State<TubeCuttingScreen> {
  // Scanned QR values
  String? machine1; // Machine
  String? machine2; // Input Tray
  String? outputtray; // Output Tray
  String? binQrCode; // Rejection Tray

  // Captured Images
  String? startImage;
  String? endImage;
  String? rejectionTrayImagePath;

  // Controllers
  final TextEditingController cutQtyController = TextEditingController();
  final TextEditingController startReadingController = TextEditingController();
  final TextEditingController endReadingController = TextEditingController();
  final TextEditingController finalQtyController = TextEditingController();
  final TextEditingController rejectionCountController =
      TextEditingController();

  int? selectedItemCount;
  List<ChildStatusModel> childStatusList = [];

  static const String baseUrl = 'https://svserpnextuat.easycloud.co.in';

  @override
  void initState() {
    super.initState();

    context.read<CreateItemCubit>().onValueChanged(
          workOrder: widget.workOrder.workOrder,
          jobCard: widget.workOrder.name,
          employee: context.user.email,
          operation: widget.title,
        );
  }

  @override
  void dispose() {
    cutQtyController.dispose();
    startReadingController.dispose();
    endReadingController.dispose();
    finalQtyController.dispose();
    rejectionCountController.dispose();
    super.dispose();
  }

  Future<void> _scanMachine() async {
    // const scannedValue = '4 Tube Cutting Machine - 01';
    final scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );

    if (scannedValue != null) {
      setState(() {
        machine1 = scannedValue;
      });
      context.read<CreateItemCubit>().onValueChanged(machine: machine1);
    }
  }

  Future<void> _scanInputTray() async {
    // final scannedValue = 'A010';
    final scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );

    if (scannedValue != null) {
      setState(() {
        machine2 = scannedValue;
      });
      context.read<CreateItemCubit>().onValueChanged(inputTray: machine2);
    }
  }

  Future<void> _scanOutputTray() async {
    // const scannedValue = 'A041';
    final scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );

    if (scannedValue != null) {
      setState(() {
        outputtray = scannedValue;
      });
      context.read<CreateItemCubit>().onValueChanged(outputTray: outputtray);
    }
  }

  Future<void> _scanRejectionTray() async {
    // const scannedValue = 'A019';
    final scannedValue = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (_) => const QrScannerScreen()),
    );

    if (scannedValue != null) {
      setState(() {
        binQrCode = scannedValue;
      });
      context
          .read<CreateItemCubit>()
          .onValueChanged(rejectiontray: binQrCode);
    }
  }

  Future<void> _capturePhoto({required bool isStart}) async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      setState(() {
        if (isStart) {
          startImage = photo.path;
          context
              .read<CreateItemCubit>()
              .onValueChanged(startImage: File(photo.path));
        } else {
          endImage = photo.path;
          context
              .read<CreateItemCubit>()
              .onValueChanged(endImage: File(photo.path));
        }
      });
    }
  }

  Future<void> _captureRejectionTrayPhoto() async {
    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo != null) {
      setState(() {
        rejectionTrayImagePath = photo.path;
        context.read<CreateItemCubit>().onValueChanged(
              rejectionImage: File(photo.path),
            );
      });
    }
  }

  void _handleStartOperation(OperationScanModel operationStatus) {
    if (machine2 == null || machine2!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan Input Tray to proceed'),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    if (operationStatus.ismachineScan == 1 &&
        (machine1 == null || machine1!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please scan Machine to proceed'),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    context.read<CreateItemCubit>().save(false);
  }

  Future<void> _handleCompleteOperation(
      OperationScanModel operationStatus) async {
    if (outputtray == null || outputtray!.isEmpty) {
      final scannedValue = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (_) => const QrScannerScreen()),
      );

      if (!mounted || scannedValue == null) return;

      setState(() {
        outputtray = scannedValue;
      });
      context.read<CreateItemCubit>().onValueChanged(outputTray: outputtray);
    }

    if (mounted) {
      context.read<CreateItemCubit>().save(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChildItemStatus, ChildItemStatusState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () => false,
              success: (data) {
                setState(() {
                  childStatusList = data;
                  log('childStatusList: $childStatusList');
                });
                final inProgressChild = data
                    .where((item) => item.status == 'In Progress')
                    .firstOrNull;
                if (inProgressChild != null) {
                  context.read<CreateItemCubit>().onValueChanged(
                        childId: inProgressChild.name,
                      );
                }
              },
            );
          },
        ),
      ],
      child: BlocBuilder<OperationStatus, OperationStatusState>(
        builder: (context, opState) {
          return opState.maybeWhen(
            orElse: () => const Scaffold(
              backgroundColor: Color(0xFFEDF2F9),
              body: Center(child: LoadingIndicator()),
            ),
            loading: () => const Scaffold(
              backgroundColor: Color(0xFFEDF2F9),
              body: Center(child: LoadingIndicator()),
            ),
            failure: (failure) => Scaffold(
              backgroundColor: const Color(0xFFEDF2F9),
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: Center(
                child: AppErrorWidget(
                  error: failure.error,
                  onRefresh: () async {
                    context
                        .cubit<OperationStatus>()
                        .request(widget.title);
                  },
                ),
              ),
            ),
            success: (data) {
              final childItem = childStatusList
                  .where((item) => item.status == 'In Progress')
                  .firstOrNull;
              final bool inProgress = (childItem != null);

              return Scaffold(
                backgroundColor: const Color(0xFFEDF2F9),
                body: Column(
                  children: [
                    // Gradient Header with Circles, Back button, Title, WO pill and Step/Metrics
                    _buildTopHeader(context, inProgress, data),
                    // Scrollable content cards
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            if (!inProgress) ...[
                              // START OPERATION PROCESS
                              _buildScanCard(data),
                              if (data.isCounterScan == 1) ...[
                                const SizedBox(height: 14),
                                _buildCounterCard(data, inProgress, childItem),
                              ],
                            ] else ...[
                              // COMPLETE OPERATION PROCESS
                              _buildOutputCard(data, inProgress, childItem),
                              if (data.isRejection == 1) ...[
                                const SizedBox(height: 14),
                                _buildRejectionCard(),
                              ],
                            ],
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    // Bottom Action Button (Start operation vs Complete operation)
                    _buildBottomBar(context, inProgress, data),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Header with gradient, circles, back button, title, WO pill, and sub-header (Step Indicator or Metrics)
  Widget _buildTopHeader(
    BuildContext context,
    bool inProgress,
    OperationScanModel data,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF04244C),
            Color(0xFF06336D),
            Color(0xFF0E60B8),
          ],
          stops: [0.0, 0.45, 1.0],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background concentric circles
          Positioned(
            top: -140,
            right: -120,
            child: _circle(380, Colors.white.withOpacity(0.04)),
          ),
          Positioned(
            top: -90,
            right: -70,
            child: _circle(260, Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            top: -140,
            right: -120,
            child: _ring(380, Colors.white.withOpacity(0.06)),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 16),
              child: Column(
                children: [
                  // Top Row: Back Button + Title + WO pill
                  Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            width: 42,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.35),
                                width: 1.2,
                              ),
                            ),
                            child: const Icon(
                              Icons.chevron_left_rounded,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: -0.3,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Work Order pill badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.35),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          widget.workOrder.workOrder.toUpperCase().startsWith('WO')
                              ? widget.workOrder.workOrder
                              : 'WO-${widget.workOrder.workOrder}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Step Indicator (Start operation) OR Metric Chips (Complete operation)
                  if (!inProgress)
                    _buildStepIndicator(data)
                  else
                    _buildMetricChips(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Step indicator for Start Operation: Scan -> Counter -> Start
  Widget _buildStepIndicator(OperationScanModel data) {
    final hasCounter = data.isCounterScan == 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Step 1: Scan
        Container(
          width: 22,
          height: 22,
          decoration: const BoxDecoration(
            color: Color(0xFF10B981),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, size: 14, color: Colors.white),
        ),
        const SizedBox(width: 8),
        const Text(
          'Scan',
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 12),
        Container(
          width: 32,
          height: 1.5,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(width: 12),
        // Step 2: Counter (if applicable)
        if (hasCounter) ...[
          Container(
            width: 22,
            height: 22,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                '2',
                style: TextStyle(
                  color: Color(0xFF0C6ECB),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Counter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 32,
            height: 1.5,
            color: Colors.white.withOpacity(0.4),
          ),
          const SizedBox(width: 12),
        ],
        // Step 3: Start
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              hasCounter ? '3' : '2',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'Start',
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // 3 Metric chips for Complete Operation: TO MAKE, COMPLETED, REJECTED
  Widget _buildMetricChips() {
    return Row(
      children: [
        Expanded(
          child: _buildMetricChip(
            value: widget.workOrder.forQnty != null
                ? '${widget.workOrder.forQnty?.toInt()}'
                : '--',
            label: 'TO MAKE',
            color: const Color(0xFF1E569C).withOpacity(0.55),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMetricChip(
            value: '${widget.workOrder.totalComplQnty.toInt()}',
            label: 'COMPLETED',
            color: const Color(0xFF1E569C).withOpacity(0.55),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _buildMetricChip(
            value: rejectionCountController.text.isNotEmpty
                ? rejectionCountController.text
                : '--',
            label: 'REJECTED',
            color: const Color(0xFF535D88).withOpacity(0.60),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricChip({
    required String value,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.white.withOpacity(0.85),
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }

  // CARD 1 (Start Operation): Scan Card
  Widget _buildScanCard(OperationScanModel data) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card Header: Green check badge + Title "Scan"
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              const Text(
                'Scan',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A2540),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // MACHINE (only when data.ismachineScan == 1)
          if (data.ismachineScan == 1) ...[
            _buildFieldLabel('MACHINE'),
            const SizedBox(height: 6),
            _buildScanItem(
              value: machine1,
              hint: 'Scan machine',
              onTap: _scanMachine,
            ),
            const SizedBox(height: 14),
          ],
          // INPUT TRAY (mandatory)
          _buildFieldLabel('INPUT TRAY'),
          const SizedBox(height: 6),
          _buildScanItem(
            value: machine2,
            hint: 'Scan input tray',
            onTap: _scanInputTray,
          ),
          const SizedBox(height: 14),
          // CUT QUANTITY
          if(widget.title == 'Tube Cutting')...[
            _buildFieldLabel('CUT QUANTITY'),
          const SizedBox(height: 6),
          
            _buildItemCountDropdown(),

          ]
          
        ],
      ),
    );
  }

  // CARD 2 (Start Operation): Counter Card
  Widget _buildCounterCard(
    OperationScanModel data,
    bool inProgress,
    ChildStatusModel? childItem,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Blue badge with "2" + Title "Counter"
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '2',
                    style: TextStyle(
                      color: Color(0xFF0284C7),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Counter',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A2540),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // START READING
          _buildFieldLabel('START READING'),
          const SizedBox(height: 6),
          _buildInputField(
            controller: startReadingController,
            hint: 'Enter counter reading',
            onChanged: (val) {
              context.read<CreateItemCubit>().onValueChanged(
                    startReading: int.tryParse(val),
                  );
            },
          ),
          const SizedBox(height: 14),
          // Capture counter photo
          _buildPhotoCaptureBox(
            imagePath: startImage,
            networkImagePath: childItem?.startImage,
            label: 'Capture counter photo',
            color: const Color(0xFF0C6ECB),
            onTap: () => _capturePhoto(isStart: true),
          ),
          // Item count dropdown (if title == 'Tube Cutting' and !inProgress)
          if (widget.title == 'Tube Cutting' && !inProgress) ...[
            // const SizedBox(height: 14),
            // _buildFieldLabel('ITEM COUNT'),
            // const SizedBox(height: 6),
            // _buildItemCountDropdown(),
          ],
        ],
      ),
    );
  }

  // CARD 1 (Complete Operation): Output Card
  Widget _buildOutputCard(
    OperationScanModel data,
    bool inProgress,
    ChildStatusModel? childItem,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Blue badge with "1" + Title "Output"
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFE0F2FE),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Color(0xFF0284C7),
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Output',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0A2540),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // OUTPUT TRAY
          _buildFieldLabel('OUTPUT TRAY'),
          const SizedBox(height: 6),
          _buildScanItem(
            value: outputtray,
            hint: 'Scan output tray',
            onTap: _scanOutputTray,
          ),
          const SizedBox(height: 14),
          // END READING (if isCounterScan == 1)
          if (data.isCounterScan == 1) ...[
            _buildFieldLabel('END READING'),
            const SizedBox(height: 6),
            _buildInputField(
              controller: endReadingController,
              hint: 'Enter counter reading',
              onChanged: (val) {
                context.read<CreateItemCubit>().onValueChanged(
                      endReading: int.tryParse(val),
                    );
              },
            ),
            const SizedBox(height: 14),
          ],
          // FINAL QUANTITY
          // _buildFieldLabel('FINAL QUANTITY'),
          // const SizedBox(height: 6),
          // _buildInputField(
          //   controller: finalQtyController,
          //   hint: 'Enter final quantity',
          //   onChanged: (val) {
          //     context.read<CreateItemCubit>().onValueChanged(
          //           cutQty: int.tryParse(val),
          //         );
          //   },
          // ),
          const SizedBox(height: 14),
          // Capture counter photo
          if (data.isCounterScan == 1) ...[
            _buildPhotoCaptureBox(
              imagePath: endImage,
              networkImagePath: childItem?.endImage,
              label: 'Capture counter photo',
              color: const Color(0xFF0C6ECB),
              onTap: () => _capturePhoto(isStart: false),
            ),
          ],
        ],
      ),
    );
  }

  // CARD 2 (Complete Operation): Rejection Card
  Widget _buildRejectionCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFFCA5A5).withOpacity(0.55),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Red circle with warning icon + Title "Rejection" in bold red
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEE2E2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.warning_amber_rounded,
                  size: 16,
                  color: Color(0xFFDC2626),
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Rejection',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFDC2626),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          // REJECTION TRAY
          _buildFieldLabel('REJECTION TRAY'),
          const SizedBox(height: 6),
          _buildScanItem(
            value: binQrCode,
            hint: 'Scan rejection tray',
            onTap: _scanRejectionTray,
          ),
          const SizedBox(height: 14),
          // REJECTION COUNT
          _buildFieldLabel('REJECTION COUNT'),
          const SizedBox(height: 6),
          _buildInputField(
            controller: rejectionCountController,
            hint: 'Enter count',
            onChanged: (val) {
              setState(() {});
              context.read<CreateItemCubit>().onValueChanged(
                    rejectedQty: int.tryParse(val),
                  );
            },
          ),
          const SizedBox(height: 14),
          // Capture tray photo
          _buildPhotoCaptureBox(
            imagePath: rejectionTrayImagePath,
            label: 'Capture tray photo',
            color: const Color(0xFFDC2626),
            onTap: _captureRejectionTrayPhoto,
          ),
        ],
      ),
    );
  }

  // Field Label helper
  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 0.4,
      ),
    );
  }

  // Scan input container (Machine, Input tray, Output tray, Rejection tray)
  Widget _buildScanItem({
    required String? value,
    required String hint,
    required VoidCallback onTap,
  }) {
    final hasValue = value != null && value.isNotEmpty;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: hasValue ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasValue
                  ? const Color(0xFF22C55E)
                  : const Color(0xFFE2E8F0),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  hasValue ? value : hint,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: hasValue ? FontWeight.w700 : FontWeight.w500,
                    color: hasValue
                        ? const Color(0xFF0F172A)
                        : const Color(0xFF94A3B8),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              if (hasValue)
                const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF16A34A),
                  size: 22,
                )
              else
                const Icon(
                  Icons.crop_free_rounded,
                  color: Color(0xFF0C6ECB),
                  size: 22,
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Text input field helper with '#' prefix icon
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.tag_rounded,
            color: Color(0xFF0C6ECB),
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0F172A),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Dashed Photo Capture box with thumbnail preview
  Widget _buildPhotoCaptureBox({
    required String? imagePath,
    String? networkImagePath,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final hasLocal = imagePath != null && imagePath.isNotEmpty;
    final hasNetwork =
        networkImagePath != null && networkImagePath.isNotEmpty;
    final hasImage = hasLocal || hasNetwork;

    return DashedBorderBox(
      color: color.withOpacity(0.55),
      strokeWidth: 1.5,
      dashWidth: 6,
      dashSpace: 4,
      borderRadius: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.04),
              borderRadius: BorderRadius.circular(16),
            ),
            child: hasImage
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: hasLocal
                            ? Image.file(
                                File(imagePath),
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                '$baseUrl$networkImagePath',
                                width: 54,
                                height: 54,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    const Icon(Icons.broken_image),
                              ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.check_circle_rounded,
                                    size: 16, color: color),
                                const SizedBox(width: 6),
                                Text(
                                  'Photo captured',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Tap to retake photo',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: color,
                        size: 22,
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: color,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  // Item count dropdown (1, 2, 3, 4)
  Widget _buildItemCountDropdown() {
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: selectedItemCount,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Color(0xFF0C6ECB),
          ),
          hint: const Text(
            'Select item count',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF94A3B8),
            ),
          ),
          items: [1, 2, 3, 4].map((count) {
            return DropdownMenuItem<int>(
              value: count,
              child: Text(
                '$count ${count == 1 ? 'pc' : 'pcs'}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0F172A),
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() {
              selectedItemCount = value;
            });
            context.read<CreateItemCubit>().onValueChanged(cutQty: value);
          },
        ),
      ),
    );
  }

  // Bottom action button: "Start operation →" vs "Complete operation ✓"
  Widget _buildBottomBar(
    BuildContext context,
    bool inProgress,
    OperationScanModel data,
  ) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
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
              ).then((_) {
                if (context.mounted) {
                  context.cubit<CreateItemCubit>().errorHandled();
                  Navigator.of(context).pop();
                }
              });
            }
          },
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: state.isLoading
                    ? null
                    : () {
                        if (inProgress) {
                          _handleCompleteOperation(data);
                        } else {
                          _handleStartOperation(data);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0C6ECB),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: state.isLoading
                    ? const LoadingIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            inProgress
                                ? 'Complete operation'
                                : 'Start operation',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.2,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            inProgress
                                ? Icons.check_rounded
                                : Icons.arrow_forward_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _circle(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      );

  Widget _ring(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 1.2),
        ),
      );
}
