import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/model/child_status_model.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class JobCardItemListScreen extends StatefulWidget {
  final String operation;
  final WorkOrderItem workOrder;
  final String selectedFilter;

  const JobCardItemListScreen({
    super.key,
    required this.operation,
    required this.workOrder,
    required this.selectedFilter,
  });

  @override
  State<JobCardItemListScreen> createState() => _JobCardItemListScreenState();
}

class _JobCardItemListScreenState extends State<JobCardItemListScreen> {
  List<ChildStatusModel> _childStatusList = [];

  @override
  void initState() {
    super.initState();
    _fetchChildStatus();
  }

  void _fetchChildStatus() {
    context.cubit<ChildItemStatus>().request(widget.workOrder.name);
  }

  Future<void> _completeOperation(ChildStatusModel childItem) async {
    await AppRoute.scanMachine.push(
      context,
      extra: {
        'name': widget.operation,
        'order': widget.workOrder,
        'filter': widget.selectedFilter,
        'childItem': childItem,
        'isNewOperation': false,
      },
    );
    if (mounted) {
      _fetchChildStatus();
    }
  }

  Future<void> _startNewOperation() async {
    await AppRoute.scanMachine.push(
      context,
      extra: {
        'name': widget.operation,
        'order': widget.workOrder,
        'filter': widget.selectedFilter,
        'childItem': null,
        'isNewOperation': true,
      },
    );
    if (mounted) {
      _fetchChildStatus();
    }
  }

  bool _isRunning(ChildStatusModel item) {
    final s = item.status?.trim().toLowerCase() ?? '';
    return s.contains('progress') ||
        s.contains('running') ||
        s.contains('open');
  }

  bool _isCompleted(ChildStatusModel item) {
    final s = item.status?.trim().toLowerCase() ?? '';
    return s.contains('complete');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F9),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: BlocConsumer<ChildItemStatus, ChildItemStatusState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () => false,
                  success: (items) {
                    setState(() {
                      _childStatusList = items;
                    });
                  },
                );
              },
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () {
                    if (_childStatusList.isNotEmpty) {
                      return _buildBody();
                    }
                    return const Center(child: LoadingIndicator());
                  },
                  failure: (failure) {
                    if (_childStatusList.isNotEmpty) {
                      return _buildBody();
                    }
                    return Center(
                      child: AppErrorWidget(
                        error: failure.error,
                        onRefresh: () async => _fetchChildStatus(),
                        isRefresh: true,
                      ),
                    );
                  },
                  orElse: () => _buildBody(),
                );
              },
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  // Top gradient header with Title, Subtitle, WO pill, and 3 Metric Chips (TO MAKE, COMPLETED, OPENED)
  Widget _buildHeader(BuildContext context) {
    // To make qty
    final woQtyNum = widget.workOrder.forQnty;
    final toMakeStr = woQtyNum != null
        ? (woQtyNum % 1 == 0 ? woQtyNum.toInt().toString() : woQtyNum.toString())
        : '--';

    // Completed qty
    final completedItems = _childStatusList.where(_isCompleted).toList();
    final double compFromItems = completedItems.fold(
      0.0,
      (sum, item) =>
          sum +
          (item.completedQty ??
              double.tryParse(item.cutQuantity ?? '') ??
              0.0),
    );
    final double completedQtyNum = widget.workOrder.totalComplQnty > 0
        ? widget.workOrder.totalComplQnty
        : compFromItems;
    final completedStr = completedQtyNum > 0
        ? (completedQtyNum % 1 == 0
            ? completedQtyNum.toInt().toString()
            : completedQtyNum.toString())
        : (widget.workOrder.totalComplQnty > 0
            ? widget.workOrder.totalComplQnty.toInt().toString()
            : '0');

    // Opened (running) items count
    final runningItems = _childStatusList.where(_isRunning).toList();
    final openedStr = runningItems.length.toString();

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
                  // Top Row: Back button + Title / Subtitle + WO Pill
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
                              Icons.arrow_back_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.operation,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                letterSpacing: -0.3,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.workOrder.name,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white.withOpacity(0.85),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Work Order pill badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
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
                  const SizedBox(height: 16),
                  // 3 Metric Chips: TO MAKE, COMPLETED, OPENED
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricChip(
                          value: toMakeStr,
                          label: 'TO MAKE',
                          color: const Color(0xFF1E569C).withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMetricChip(
                          value: completedStr,
                          label: 'COMPLETED',
                          color: const Color(0xFF1E569C).withOpacity(0.55),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildMetricChip(
                          value: openedStr,
                          label: 'OPENED',
                          color: const Color(0xFF535D88).withOpacity(0.60),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header metric chip matching scan_machine_screen.dart
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

  Widget _circle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _ring(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 1.2),
      ),
    );
  }

  Widget _buildBody() {
    final runningItems = _childStatusList.where(_isRunning).toList();
    final completedItems = _childStatusList.where(_isCompleted).toList();

    return RefreshIndicator(
      onRefresh: () async => _fetchChildStatus(),
      color: const Color(0xFF0C6ECB),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRunningSection(runningItems),
            const SizedBox(height: 22),
            _buildCompletedSection(completedItems),
          ],
        ),
      ),
    );
  }

  Widget _buildRunningSection(List<ChildStatusModel> runningItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Running machines',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A2540),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        if (runningItems.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04244C).withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
                SizedBox(width: 8),
                Text(
                  'No machines currently running',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          )
        else
          ...runningItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildRunningCard(item),
            ),
          ),
      ],
    );
  }

  Widget _buildRunningCard(ChildStatusModel item) {
    final machineName = item.machineId?.isNotEmpty == true
        ? item.machineId!
        : (item.name?.isNotEmpty == true ? item.name! : 'Machine');

    final parts = <String>[];
    if (item.trayId != null && item.trayId!.trim().isNotEmpty) {
      parts.add('Input tray ${item.trayId!.trim()}');
    }
    if (item.cutQuantity != null &&
        item.cutQuantity!.trim().isNotEmpty &&
        item.cutQuantity!.trim() != '0') {
      parts.add('Cut qty ${item.cutQuantity!.trim()}');
    }
    final startTime = item.formattedStartTime;
    if (startTime != null && startTime.isNotEmpty) {
      parts.add('Started $startTime');
    }

    final subtitle = parts.isNotEmpty ? parts.join(' · ') : 'In Progress';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  machineName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0A2540),
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          ElevatedButton(
            onPressed: () => _completeOperation(item),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C6ECB),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            child: const Text(
              'Complete',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompletedSection(List<ChildStatusModel> completedItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Completed',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w800,
            color: Color(0xFF0A2540),
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 12),
        if (completedItems.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04244C).withOpacity(0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  size: 20,
                  color: Color(0xFF94A3B8),
                ),
                SizedBox(width: 8),
                Text(
                  'No completed operations yet',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          )
        else
          ...completedItems.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildCompletedCard(item),
            ),
          ),
      ],
    );
  }

  Widget _buildCompletedCard(ChildStatusModel item) {
    final machine = item.machineId?.isNotEmpty == true
        ? item.machineId!
        : (item.name?.isNotEmpty == true ? item.name! : '');

    final outputTray = item.outputTray?.isNotEmpty == true
        ? item.outputTray!
        : (item.trayId?.isNotEmpty == true ? item.trayId! : '');

    final parts = <String>[];
    if (machine.isNotEmpty) parts.add(machine);
    if (outputTray.isNotEmpty) parts.add('Output tray $outputTray');

    if (item.completedQty != null && item.completedQty! > 0) {
      final qtyStr = item.completedQty! % 1 == 0
          ? item.completedQty!.toInt().toString()
          : item.completedQty!.toString();
      parts.add('$qtyStr qty');
    } else if (item.cutQuantity != null &&
        item.cutQuantity!.trim().isNotEmpty &&
        item.cutQuantity!.trim() != '0') {
      parts.add('${item.cutQuantity!.trim()} qty');
    }

    final timeRange = item.formattedTimeRange;
    if (timeRange != null && timeRange.isNotEmpty) {
      parts.add(timeRange);
    }

    final line = parts.isNotEmpty ? parts.join(' · ') : 'Completed';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
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
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF10B981),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check,
              size: 20,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 1,
            height: 32,
            color: const Color(0xFFE2E8F0),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              line,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF0A2540),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Floating bottom action button: "New operation →"
  Widget _buildBottomBar() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 20),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: _startNewOperation,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0C6ECB),
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'New operation',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
