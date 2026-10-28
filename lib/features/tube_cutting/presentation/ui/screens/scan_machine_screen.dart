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
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/counter_reading_widget.dart';
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

  // Loading & error states for OCR counter reading
  bool isReadingStartCounter = false;
  bool isReadingEndCounter = false;
  String? startReadingError;
  String? endReadingError;

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
    // const scannedValue = 'A007';
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
      context.read<CreateItemCubit>().onValueChanged(rejectiontray: binQrCode);
    }
  }

  Future<void> _capturePhoto({required bool isStart}) async {
    final CounterReaderService counterReaderService = CounterReaderService();

    final picker = ImagePicker();
    final photo = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (photo == null) return;

    setState(() {
      if (isStart) {
        startReadingController.clear();
        isReadingStartCounter = true;
        startReadingError = null;
        context.read<CreateItemCubit>().onValueChanged(startReading: null);
      } else {
        endReadingController.clear();
        isReadingEndCounter = true;
        endReadingError = null;
        context.read<CreateItemCubit>().onValueChanged(endReading: null);
      }
    });

    try {
      final CounterReadingResult result =
          await counterReaderService.readFile(photo);

      if (!mounted) return;

      if (result.reading != null && result.reading!.trim().isNotEmpty) {
        final readingText = result.reading!.trim();
        setState(() {
          if (isStart) {
            startImage = photo.path;
            isReadingStartCounter = false;
            startReadingError = null;
            startReadingController.text = readingText;
          } else {
            endImage = photo.path;
            isReadingEndCounter = false;
            endReadingError = null;
            endReadingController.text = readingText;
          }
        });

        if (isStart) {
          context.read<CreateItemCubit>().onValueChanged(
                startImage: File(photo.path),
                startReading: int.tryParse(readingText),
              );
        } else {
          context.read<CreateItemCubit>().onValueChanged(
                endImage: File(photo.path),
                endReading: int.tryParse(readingText),
              );
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle_rounded,
                    color: Colors.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Counter reading captured: $readingText',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF16A34A),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        final errorMsg =
            (result.error != null && result.error!.trim().isNotEmpty)
                ? result.error!.trim()
                : 'No readings captured, take a valid photo.';

        setState(() {
          if (isStart) {
            startImage = null;
            isReadingStartCounter = false;
            startReadingError = errorMsg;
          } else {
            endImage = null;
            isReadingEndCounter = false;
            endReadingError = errorMsg;
          }
        });

        if (isStart) {
          context.read<CreateItemCubit>().clearStartPhoto();
        } else {
          context.read<CreateItemCubit>().clearEndPhoto();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.warning_amber_rounded,
                    color: Colors.white, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    errorMsg,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFFDC2626),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } catch (e) {
      log('Error reading counter: $e');
      if (!mounted) return;
      setState(() {
        if (isStart) {
          startImage = null;
          isReadingStartCounter = false;
          startReadingError = 'No readings captured, take a valid photo';
        } else {
          endImage = null;
          isReadingEndCounter = false;
          endReadingError = 'No readings captured, take a valid photo';
        }
      });

      if (isStart) {
        context.read<CreateItemCubit>().clearStartPhoto();
      } else {
        context.read<CreateItemCubit>().clearEndPhoto();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.warning_amber_rounded,
                  color: Colors.white, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'No readings captured, take a valid photo.',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xFFDC2626),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 4),
        ),
      );
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

    if (!mounted) return;

    // Show popup dialog with start reading, end reading, final qnty (end - start), and scrap count
    final confirmed = await _showCompleteConfirmationDialog();

    if (confirmed == true && mounted) {
      final endReadingVal = int.tryParse(endReadingController.text.trim());
      if (endReadingVal != null) {
        context.read<CreateItemCubit>().onValueChanged(endReading: endReadingVal);
      }
      final scrapVal = int.tryParse(rejectionCountController.text.trim());
      if (scrapVal != null) {
        context.read<CreateItemCubit>().onValueChanged(rejectedQty: scrapVal);
      }
      context.read<CreateItemCubit>().save(true);
    }
  }

  // Confirmation dialog showing Start Reading, End Reading, Final Qnty (End - Start), and Scrap Count
  Future<bool?> _showCompleteConfirmationDialog() {
    final inProgressChild = childStatusList
        .where((item) => item.status == 'In Progress')
        .firstOrNull;

    final num? startReadingNum = inProgressChild?.startReading ??
        num.tryParse(startReadingController.text.trim()) ??
        context.read<CreateItemCubit>().state.form.startReadings;

    final num? endReadingNum =
        num.tryParse(endReadingController.text.trim());
        // context.read<CreateItemCubit>().state.form.endReadings;

    final num? finalQty = (endReadingNum != null && startReadingNum != null)
        ? (endReadingNum - startReadingNum)
        : null;

    final int scrapCount =
        int.tryParse(rejectionCountController.text.trim()) ??
        context.read<CreateItemCubit>().state.form.rejectionCounter ??
        0;

    String formatNum(num? n) {
      if (n == null) return '--';
      if (n % 1 == 0) return n.toInt().toString();
      return n.toString();
    }

    final startReadingStr = formatNum(startReadingNum);
    final endReadingStr = formatNum(endReadingNum);
    final finalQtyStr = formatNum(finalQty);
    final scrapCountStr = scrapCount.toString();

    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 380),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04244C).withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header: Icon + Title
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.fact_check_rounded,
                        color: Color(0xFF0C6ECB),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Complete Operation',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                              letterSpacing: -0.3,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Review readings before submission',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Details Card Container
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: const Color(0xFFE2E8F0),
                      width: 1.2,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Row 1: Start Reading & End Reading
                      Row(
                        children: [
                          Expanded(
                            child: _buildDialogMetricTile(
                              title: 'START READING',
                              value: startReadingStr,
                              icon: Icons.tag_rounded,
                              iconColor: const Color(0xFF0284C7),
                              iconBg: const Color(0xFFE0F2FE),
                            ),
                          ),
                          Container(
                            height: 48,
                            width: 1.2,
                            color: const Color(0xFFE2E8F0),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: _buildDialogMetricTile(
                              title: 'END READING',
                              value: endReadingStr,
                              icon: Icons.tag_rounded,
                              iconColor: const Color(0xFF0C6ECB),
                              iconBg: const Color(0xFFE0F2FE),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Color(0xFFE2E8F0), height: 1),
                      const SizedBox(height: 12),

                      // Row 2: Final Quantity (End - Start) & Scrap Count
                      Row(
                        children: [
                          Expanded(
                            child: _buildDialogMetricTile(
                              title: 'FINAL QNTY',
                              subtitle: '(End - Start)',
                              value: finalQtyStr,
                              icon: Icons.check_circle_rounded,
                              iconColor: const Color(0xFF16A34A),
                              iconBg: const Color(0xFFDCFCE7),
                              valueColor: const Color(0xFF15803D),
                            ),
                          ),
                          Container(
                            height: 48,
                            width: 1.2,
                            color: const Color(0xFFE2E8F0),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                          Expanded(
                            child: _buildDialogMetricTile(
                              title: 'SCRAP COUNT',
                              value: scrapCountStr,
                              icon: Icons.delete_outline_rounded,
                              iconColor: const Color(0xFFDC2626),
                              iconBg: const Color(0xFFFEE2E2),
                              valueColor: const Color(0xFFB91C1C),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Action Buttons: "No" vs "Confirm"
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                          onPressed: () => Navigator.of(ctx).pop(false),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFFCBD5E1),
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            backgroundColor: Colors.white,
                          ),
                          child: const Text(
                            'No',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(ctx).pop(true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0C6ECB),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Dialog metric tile helper
  Widget _buildDialogMetricTile({
    required String title,
    String? subtitle,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Icon(icon, size: 14, color: iconColor),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF64748B),
                      letterSpacing: 0.3,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: valueColor ?? const Color(0xFF0F172A),
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
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
                    context.cubit<OperationStatus>().request(widget.title);
                  },
                  isRefresh: true,
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
                              if (childItem != null &&
                                  _hasStartDetails(childItem)) ...[
                                _buildStartDetailsCard(childItem),
                                const SizedBox(height: 14),
                              ],
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
                          widget.workOrder.workOrder
                                  .toUpperCase()
                                  .startsWith('WO')
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
          if (widget.title == 'Tube Cutting') ...[
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
            isReadOnly: true,
            controller: startReadingController,
            hint: 'Enter counter reading',
            isLoading: isReadingStartCounter,
            errorText: startReadingError,
            onChanged: (val) {
              if (startReadingError != null) {
                setState(() {
                  startReadingError = null;
                });
              }
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
            isLoading: isReadingStartCounter,
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

  bool _hasStartDetails(ChildStatusModel childItem) {
    final hasMachine =
        childItem.machineId != null && childItem.machineId!.trim().isNotEmpty;
    final hasTray =
        childItem.trayId != null && childItem.trayId!.trim().isNotEmpty;
    final hasStartReading =
        childItem.startReading != null && childItem.startReading! > 0;
    final hasCutQuantity = childItem.cutQuantity != null &&
        childItem.cutQuantity!.trim().isNotEmpty &&
        childItem.cutQuantity!.trim() != '0';
    final hasStartImage =
        childItem.startImage != null && childItem.startImage!.trim().isNotEmpty;

    return hasMachine ||
        hasTray ||
        hasStartReading ||
        hasCutQuantity ||
        hasStartImage;
  }

  // CARD: Start Operation Details (Machine ID, Input Tray ID, Start Reading, Cut Qnty, Counter Start Image)
  Widget _buildStartDetailsCard(ChildStatusModel childItem) {
    final machineId = childItem.machineId;
    final trayId = childItem.trayId;
    final startImage = childItem.startImage;
    final startReading = childItem.startReading;
    final cutQuantity = childItem.cutQuantity;

    final bool hasMachine = machineId != null && machineId.trim().isNotEmpty;
    final bool hasTray = trayId != null && trayId.trim().isNotEmpty;
    final bool hasStartReading = startReading != null && startReading > 0;
    final bool hasCutQuantity = cutQuantity != null &&
        cutQuantity.trim().isNotEmpty &&
        cutQuantity.trim() != '0';
    final bool hasStartImage =
        startImage != null && startImage.trim().isNotEmpty;

    if (!hasMachine &&
        !hasTray &&
        !hasStartReading &&
        !hasCutQuantity &&
        !hasStartImage) {
      return const SizedBox.shrink();
    }

    final String startReadingFormatted =
        hasStartReading ? startReading.toString() : '';
    final String cutQuantityFormatted =
        hasCutQuantity ? cutQuantity!.trim() : '';

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
          // Header: Info icon + Title "Start Details" + Badge "IN PROGRESS"
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
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: Color(0xFF0284C7),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Start Details',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0A2540),
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.timelapse_rounded,
                        size: 12, color: Color(0xFF2563EB)),
                    SizedBox(width: 4),
                    Text(
                      'IN PROGRESS',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1D4ED8),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // 1. MACHINE ID (only if not empty)
          if (hasMachine) ...[
            _buildFieldLabel('MACHINE ID'),
            const SizedBox(height: 6),
            _buildReadOnlyField(
              icon: Icons.precision_manufacturing_outlined,
              value: machineId!.trim(),
              placeholder: '',
            ),
            const SizedBox(height: 14),
          ],

          // 2. INPUT TRAY ID (only if not empty)
          if (hasTray) ...[
            _buildFieldLabel('INPUT TRAY ID'),
            const SizedBox(height: 6),
            _buildReadOnlyField(
              icon: Icons.inbox_outlined,
              value: trayId!.trim(),
              placeholder: '',
            ),
            const SizedBox(height: 14),
          ],

          // 3. START READING & CUT QUANTITY (only if not empty)
          if (hasStartReading && hasCutQuantity) ...[
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel('START READING'),
                      const SizedBox(height: 6),
                      _buildReadOnlyField(
                        icon: Icons.tag_rounded,
                        value: startReadingFormatted,
                        placeholder: '',
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFieldLabel('CUT QUANTITY'),
                      const SizedBox(height: 6),
                      _buildReadOnlyField(
                        icon: Icons.content_cut_rounded,
                        value: cutQuantityFormatted,
                        placeholder: '',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
          ] else if (hasStartReading) ...[
            _buildFieldLabel('START READING'),
            const SizedBox(height: 6),
            _buildReadOnlyField(
              icon: Icons.tag_rounded,
              value: startReadingFormatted,
              placeholder: '',
            ),
            const SizedBox(height: 14),
          ] else if (hasCutQuantity) ...[
            _buildFieldLabel('CUT QUANTITY'),
            const SizedBox(height: 6),
            _buildReadOnlyField(
              icon: Icons.content_cut_rounded,
              value: cutQuantityFormatted,
              placeholder: '',
            ),
            const SizedBox(height: 14),
          ],

          // 4. COUNTER START IMAGE (only if not empty)
          if (hasStartImage) ...[
            _buildFieldLabel('COUNTER START IMAGE'),
            const SizedBox(height: 6),
            _buildStartImageViewer(startImage.trim()),
          ],
        ],
      ),
    );
  }

  // Read-only Field tile for displaying machine & tray values
  Widget _buildReadOnlyField({
    required IconData icon,
    required String value,
    required String placeholder,
  }) {
    final bool isEmpty = value == '--';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
          Icon(
            icon,
            size: 20,
            color: isEmpty ? const Color(0xFF94A3B8) : const Color(0xFF0284C7),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isEmpty ? FontWeight.w500 : FontWeight.w700,
                color:
                    isEmpty ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
                letterSpacing: -0.2,
              ),
            ),
          ),
          if (!isEmpty)
            const Icon(
              Icons.check_circle_rounded,
              size: 18,
              color: Color(0xFF10B981),
            ),
        ],
      ),
    );
  }

  // Counter start image viewer box with zoom on tap
  Widget _buildStartImageViewer(String? imagePath) {
    final bool hasImage = imagePath != null && imagePath.isNotEmpty;
    if (!hasImage) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFFE2E8F0),
            width: 1.2,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_not_supported_outlined,
                size: 20, color: Color(0xFF94A3B8)),
            SizedBox(width: 8),
            Text(
              'No counter start photo recorded',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ],
        ),
      );
    }

    final fullUrl =
        imagePath.startsWith('http') ? imagePath : '$baseUrl$imagePath';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showFullImageDialog(
          context,
          fullUrl,
          'Counter Start Photo',
        ),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF0FDF4),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF86EFAC).withOpacity(0.7),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  fullUrl,
                  width: 58,
                  height: 58,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 58,
                    height: 58,
                    color: const Color(0xFFE2E8F0),
                    child: const Icon(
                      Icons.broken_image,
                      size: 24,
                      color: Color(0xFF94A3B8),
                    ),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(
                      width: 58,
                      height: 58,
                      color: const Color(0xFFF1F5F9),
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 16,
                          color: Color(0xFF16A34A),
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Start Counter Photo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF15803D),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      imagePath,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF64748B),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Tap to view full photo',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0284C7),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF86EFAC).withOpacity(0.8),
                  ),
                ),
                child: const Icon(
                  Icons.zoom_in_rounded,
                  size: 20,
                  color: Color(0xFF15803D),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Full-screen image preview dialog
  void _showFullImageDialog(
    BuildContext context,
    String imageUrl,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon:
                        const Icon(Icons.close, color: Colors.white, size: 20),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Container(
                color: Colors.black,
                constraints: const BoxConstraints(maxHeight: 500),
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: Center(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => Container(
                        padding: const EdgeInsets.all(32),
                        color: Colors.black,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.broken_image,
                                size: 48, color: Colors.white54),
                            SizedBox(height: 12),
                            Text(
                              'Failed to load image',
                              style: TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF0F172A),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16)),
              ),
              alignment: Alignment.center,
              child: const Text(
                'Pinch to zoom',
                style: TextStyle(color: Colors.white60, fontSize: 12),
              ),
            ),
          ],
        ),
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
              isReadOnly: true,
              controller: endReadingController,
              hint: 'Enter counter reading',
              isLoading: isReadingEndCounter,
              errorText: endReadingError,
              onChanged: (val) {
                if (endReadingError != null) {
                  setState(() {
                    endReadingError = null;
                  });
                }
                context.read<CreateItemCubit>().onValueChanged(
                      endReading: int.tryParse(val),
                    );
              },
            ),
            const SizedBox(height: 14),
          ],
          // Capture counter photo
          if (data.isCounterScan == 1) ...[
            _buildPhotoCaptureBox(
              imagePath: endImage,
              networkImagePath: childItem?.endImage,
              label: 'Capture counter photo',
              color: const Color(0xFF0C6ECB),
              isLoading: isReadingEndCounter,
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
                'Scrap',
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
          _buildFieldLabel('SCRAP TRAY'),
          const SizedBox(height: 6),
          _buildScanItem(
            value: binQrCode,
            hint: 'Scan scrap tray',
            onTap: _scanRejectionTray,
          ),
          const SizedBox(height: 14),
          // REJECTION COUNT
          _buildFieldLabel('SCRAP COUNT'),
          const SizedBox(height: 6),
          _buildInputField(
             isReadOnly: false,
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
              color:
                  hasValue ? const Color(0xFF22C55E) : const Color(0xFFE2E8F0),
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

  // Text input field helper with '#' prefix icon, loading indicator & error message
  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required ValueChanged<String> onChanged,
    bool isLoading = false,
    required bool isReadOnly,
    String? errorText,
  }) {
    final bool hasError = errorText != null && errorText.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: hasError
                  ? const Color(0xFFEF4444)
                  : (isLoading
                      ? const Color(0xFF0C6ECB).withOpacity(0.5)
                      : const Color(0xFFE2E8F0)),
              width: 1.2,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.tag_rounded,
                color: hasError
                    ? const Color(0xFFEF4444)
                    : const Color(0xFF0C6ECB),
                size: 20,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  readOnly: isReadOnly,
                  controller: controller,
                  onChanged: onChanged,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F172A),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: isLoading ? 'Reading counter...' : hint,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          isLoading ? FontWeight.w500 : FontWeight.w400,
                      color: isLoading
                          ? const Color(0xFF0C6ECB)
                          : const Color(0xFF94A3B8),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              if (isLoading)
                const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(Color(0xFF0C6ECB)),
                  ),
                ),
            ],
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 13,
                  color: Color(0xFFDC2626),
                ),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    errorText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFDC2626),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  // Dashed Photo Capture box with thumbnail preview and loading indicator
  Widget _buildPhotoCaptureBox({
    required String? imagePath,
    String? networkImagePath,
    required String label,
    required Color color,
    required VoidCallback onTap,
    bool isLoading = false,
  }) {
    final hasLocal = imagePath != null && imagePath.isNotEmpty;
    final hasNetwork = networkImagePath != null && networkImagePath.isNotEmpty;
    final hasImage = hasLocal || hasNetwork;

    return DashedBorderBox(
      color: isLoading ? color : color.withOpacity(0.55),
      strokeWidth: 1.5,
      dashWidth: 6,
      dashSpace: 4,
      borderRadius: 16,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : onTap,
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
                                if (isLoading)
                                  SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor:
                                          AlwaysStoppedAnimation<Color>(color),
                                    ),
                                  )
                                else
                                  Icon(Icons.check_circle_rounded,
                                      size: 16, color: color),
                                const SizedBox(width: 6),
                                Text(
                                  isLoading
                                      ? 'Reading counter...'
                                      : 'Photo captured',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: color,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isLoading
                                  ? 'Analyzing photo for readings'
                                  : 'Tap to retake photo',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (isLoading)
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        )
                      else
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
                      if (isLoading)
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                          ),
                        )
                      else
                        Icon(
                          Icons.camera_alt_outlined,
                          color: color,
                          size: 20,
                        ),
                      const SizedBox(width: 10),
                      Text(
                        isLoading ? 'Reading counter...' : label,
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
