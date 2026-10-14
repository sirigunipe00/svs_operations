import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/operation_scan_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/create_item_cubit.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/screens/qr_scanner_screen.dart';
import 'package:svs_operations/features/tube_cutting/presentation/ui/widgets/dashed_border_box.dart';
import 'package:svs_operations/features/tube_cutting/presentation/work_station_screen.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class TubeCuttingScreen extends StatefulWidget {
  final String title;
  final String selectedFilter;
  final WorkOrderItem workOrder;
  const TubeCuttingScreen(
      {super.key, required this.title, required this.workOrder, required this.selectedFilter});

  @override
  State<TubeCuttingScreen> createState() => _TubeCuttingScreenState();
}

class _TubeCuttingScreenState extends State<TubeCuttingScreen> {
  String? machine1;
  String? machine2;
  bool isNext = false;

  List<ChildStatusModel> childStatusList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Text('(${DateFormat('dd/MM/yy').format(DateTime.now())})',
                style:
                    const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF7F9FB),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                'ORDER DETAILS',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 6),
              _buildWorkOrderCard(widget.workOrder),
              const SizedBox(height: 12),
              MultiBlocListener(
                listeners: [
                  BlocListener<ChildItemStatus, ChildItemStatusState>(
                    listener: (context, state) {
                      state.maybeWhen(
                        orElse: () => false,
                        success: (data) {
                          setState(() {
                            childStatusList = data;
                            log('childsttas...:$childStatusList');
                          });
                        },
                      );
                    },
                  ),
                ],
                child: Container(),
              ),
              BlocBuilder<OperationStatus, OperationStatusState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => const SizedBox(),
                    failure: (failure) => AppErrorWidget(
                      error: failure.error,
                    ),
                    loading: () => const Center(
                      child: LoadingIndicator(),
                    ),
                    success: (data) {
                      final childItem = childStatusList
                          .where(
                            (item) => item.status == 'In Progress',
                          )
                          .firstOrNull;

                      final isValid =
                          (data.ismachineScan != 1 || machine1 != null) &&
                              machine2 != null;

                      if (childItem != null) {
                        return BlocProvider(
                          create: (context) =>
                              TubeCuttingBlocProvider.get().workOrderList(),
                          child: TubeCuttingWorkStationScreen(
                            selectedfilter: widget.selectedFilter,
                            title: widget.title,
                            operationStatus: data,
                            workOrder: widget.workOrder,
                            scanMachine: machine1 ?? '',
                            scanTray: machine2 ?? '',
                            childItem: childItem,
                            inProgress: childItem != null,
                          ),
                        );
                      } else if (isValid && isNext) {
                        return BlocProvider(
                          create: (context) =>
                              TubeCuttingBlocProvider.get().workOrderList(),
                          child: TubeCuttingWorkStationScreen(
                            selectedfilter: widget.selectedFilter,
                            title: widget.title,
                            operationStatus: data,
                            workOrder: widget.workOrder,
                            scanMachine: machine1 ?? '',
                            scanTray: machine2 ?? '',
                            childItem: childItem ?? ChildStatusModel(),
                            inProgress: childItem != null,
                          ),
                        );
                      } else {
                        return _buildScanPart(data);
                      }
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }

  Widget _buildScanPart(OperationScanModel data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (data.ismachineScan == 1) ...[
              Expanded(
                child: _buildScanCard1(context),
              ),
            ],
            const SizedBox(width: 12),
            Expanded(
              child: _buildScanCard2(context),
            ),
          ],
        ),
        SizedBox(
          height: 300,
        ),
        if ((data.ismachineScan != 1 || machine1 != null) && machine2 != null)
          ElevatedButton(
  onPressed: () {
    setState(() {
      isNext = true;
    });
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: AppColors.blue,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(
      horizontal: 32,
      vertical: 14,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  child: const Text(
    'Next',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
  ),
)
      ],
    );
  }

  Widget _buildWorkOrderCard(WorkOrderItem order) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: const Color(0xFFE0E9F4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 9,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Left status indicator
            Container(
              width: 3,
              decoration: const BoxDecoration(
                // color: order.co,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(13),
                  bottomLeft: Radius.circular(13),
                ),
              ),
            ),

            // Content
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            order.workOrder,
                            style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: AppColors.blue),
                            softWrap: true,
                          ),
                        ),
                        const SizedBox(width: 10),
                        _buildStatusBadge(order),
                      ],
                    ),

                    const SizedBox(height: 6),

                    // Bottom row
                    Row(
                      children: [
                        Text(
                          order.productionItem,
                          style: const TextStyle(
                            // fontSize: 26,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF61728D),
                          ),
                        ),
                        const Spacer(),
                        _buildQuantity(order),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantity(WorkOrderItem order) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: order.forQnty.toString(),
            style: const TextStyle(
              // fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Color(0xFF10182C),
            ),
          ),
          const TextSpan(
            text: ' ',
          ),
          TextSpan(
            text: '(${order.totalComplQnty})',
            style: const TextStyle(
              // fontSize: 23,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1687CC),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanCard1(BuildContext context) {
    return CustomPaint(
        painter: DashedRoundedBorderPainter(
          color: const Color(0xFF59AEE2),
          strokeWidth: 3,
          dashWidth: 10,
          dashSpace: 8,
          radius: 30,
        ),
        child: DashedBorderBox(
          borderRadius: 20,
          color: const Color(0xFF59AEE2),
          dashSpace: 6,
          dashWidth: 5,
          strokeWidth: 2,
          child: InkWell(
            onTap: () async {
              // final String? scannedValue = 'Tube Cutting Machine - 05';
              final String? scannedValue = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (_) => const QrScannerScreen(),
                ),
              );

              if (scannedValue != null) {
                setState(() {
                  machine1 = scannedValue;

                  context
                      .read<CreateItemCubit>()
                      .onValueChanged(machine: machine1);
                });

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.green,
                      content: Column(
                        children: [
                          Text(
                            'Machine scanned successfully',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Scan the Tray to continue',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQrButton(context, machine1),
                  const SizedBox(height: 33),
                  Text(
                    machine1 ?? 'SCAN MACHINE',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    machine1 != null
                        ? 'Scan Successful'
                        : 'Scan the QR to register machine',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF92A3BD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildScanCard2(BuildContext context) {
    return CustomPaint(
        painter: DashedRoundedBorderPainter(
          color: const Color(0xFF59AEE2),
          strokeWidth: 3,
          dashWidth: 10,
          dashSpace: 8,
          radius: 30,
        ),
        child: DashedBorderBox(
          borderRadius: 20,
          color: const Color(0xFF59AEE2),
          dashSpace: 6,
          dashWidth: 5,
          strokeWidth: 2,
          child: InkWell(
            onTap: () async {
              // final String? scannedValue = 'A010';
              final String? scannedValue = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (_) => const QrScannerScreen(),
                ),
              );

              if (scannedValue != null) {
                setState(() {
                  machine2 = scannedValue;

                  context
                      .read<CreateItemCubit>()
                      .onValueChanged(inputTray: machine2);
                });

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: AppColors.green,
                      content: Column(
                        children: [
                          Text(
                            'Tray scanned successfully',
                            style: TextStyle(fontSize: 14),
                          ),
                          Text(
                            'Capture the machine counter to continue',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              }
            },
            child: Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQrButton(context, machine2),
                  const SizedBox(height: 33),
                  Text(
                    machine2 ?? 'INWARD TRAY',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    machine2 != null
                        ? 'Scan Succesful'
                        : 'Scan the QR to register machine',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF92A3BD),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildQrButton(BuildContext context, String? item) {
    return Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: item != null ? Colors.green : const Color(0xFF59AEE2),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF188FD2).withOpacity(0.25),
              blurRadius: 18,
              spreadRadius: 4,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Center(
          child: item != null
              ? const Icon(
                  Icons.check,
                  size: 30,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 30,
                  color: Colors.white,
                ),
        ));
  }
}

Widget _buildStatusBadge(WorkOrderItem order) {
  Color backgroundColor;

  switch (order.status) {
    case 'Open':
      backgroundColor = const Color(0xFFFFDCDD);
      break;

    case 'In-Progress':
      backgroundColor = const Color(0xFFDCECF9);
      break;

    case 'Completed':
      backgroundColor = const Color(0xFFD9F2E6);
      break;

    default:
      backgroundColor = Colors.grey.shade200;
  }

  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 8,
      vertical: 2,
    ),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(25),
    ),
    child: Text(
      order.status,
      style: const TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w400,
        // color: order.color,
      ),
    ),
  );
}

class DashedRoundedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  DashedRoundedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.dashSpace,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final path = Path();

    final rect = Rect.fromLTWH(
      strokeWidth / 2,
      strokeWidth / 2,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    path.addRRect(
      RRect.fromRectAndRadius(
        rect,
        Radius.circular(radius),
      ),
    );

    _drawDashedPath(
      canvas,
      path,
      paint,
      dashWidth,
      dashSpace,
    );
  }

  void _drawDashedPath(
    Canvas canvas,
    Path path,
    Paint paint,
    double dashWidth,
    double dashSpace,
  ) {
    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final double nextDistance = distance + dashWidth;

        final Path dash = metric.extractPath(
          distance,
          nextDistance > metric.length ? metric.length : nextDistance,
        );

        canvas.drawPath(dash, paint);

        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(
    covariant DashedRoundedBorderPainter oldDelegate,
  ) {
    return oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.dashWidth != dashWidth ||
        oldDelegate.dashSpace != dashSpace ||
        oldDelegate.radius != radius;
  }
}
