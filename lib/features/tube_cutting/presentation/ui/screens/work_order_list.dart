import 'package:dartz/dartz.dart' as datrz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class WorkOrderListScreen extends StatefulWidget {
  final String operation;
  const WorkOrderListScreen({super.key, required this.operation});

  @override
  State<WorkOrderListScreen> createState() => _WorkOrderListScreenState();
}

class _WorkOrderListScreenState extends State<WorkOrderListScreen> {
  final TextEditingController searchController = TextEditingController();
  String selectedFilter = 'Open';
  String searchQuery = '';

  int _openCount = 0;
  int _inProgressCount = 0;
  int _completedCount = 0;

  @override
  void initState() {
    super.initState();
    selectedFilter = 'Open';

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _fetchWorkOrders();
    });
  }

  void _fetchWorkOrders() {
    context.cubit<WorkOrderList>().request(
          datrz.Tuple3(
            widget.operation,
            '',
            'All',
          ),
        );
  }

  void _onFilterSelected(String filter) {
    if (selectedFilter == filter) return;
    setState(() {
      selectedFilter = filter;
    });
  }

  void _updateCounts(List<WorkOrderItem> data) {
    if (searchQuery.isEmpty) {
      setState(() {
        
      _openCount =
          data.where((item) => item.status.toLowerCase() == 'open').length;
      _inProgressCount = data
          .where((item) => item.status.toLowerCase().contains('progress'))
          .length;
      _completedCount =
          data.where((item) => item.status.toLowerCase() == 'completed').length;
      });
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F9),
      body: Column(
        children: [
          // Fixed Top Section: Header background, Top bar, Statistics card, and Search + Filter row
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Header gradient background with concentric rings
              _buildHeaderBackground(context),
              // Header Content
              SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    // Top Bar: Back button + Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
                      child: _buildTopBar(context),
                    ),
                    const SizedBox(height: 4),
                    // Statistics Card (Open, In progress, Completed)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildStatisticsCard(),
                    ),
                    const SizedBox(height: 14),
                    // Search & Filter Row placed BELOW the Statistics Card
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildSearchAndFilterRow(),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
          // Work Order List with RefreshIndicator (spinner appears at top of the list)
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _fetchWorkOrders(),
              color: const Color(0xFF0C6ECB),
              backgroundColor: Colors.white,
              child: BlocConsumer<WorkOrderList, WorkOrderListState>(
                listener: (context, state) {
                  state.maybeWhen(
                    success: (data) {
                      if (searchQuery.isEmpty) {
                        _updateCounts(data);
                      }
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  return state.maybeWhen(
                    orElse: () => ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(child: LoadingIndicator()),
                        ),
                      ],
                    ),
                    loading: () => ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      children: const [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 60),
                          child: Center(child: LoadingIndicator()),
                        ),
                      ],
                    ),
                    failure: (failure) => ListView(
                      physics: const AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics(),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 40),
                          child: AppErrorWidget(
                            error: failure.error,
                            onRefresh: () async => _fetchWorkOrders(),
                          ),
                        ),
                      ],
                    ),
                    success: (data) {
                      final filteredList = data.where((item) {
                        // Status filter (unless 'All')
                        if (selectedFilter.toLowerCase() != 'all') {
                          final s = item.status.toLowerCase();
                          if (selectedFilter.toLowerCase() == 'open') {
                            if (s != 'open') return false;
                          } else if (selectedFilter
                              .toLowerCase()
                              .contains('progress')) {
                            if (!s.contains('progress')) return false;
                          } else if (selectedFilter.toLowerCase() ==
                              'completed') {
                            if (s != 'completed') return false;
                          }
                        }

                        // Search query filter
                        if (searchQuery.isNotEmpty) {
                          final q = searchQuery.toLowerCase();
                          return item.workOrder.toLowerCase().contains(q) ||
                              item.name.toLowerCase().contains(q) ||
                              item.productionItem.toLowerCase().contains(q);
                        }

                        return true;
                      }).toList();

                      if (filteredList.isEmpty) {
                        return ListView(
                          physics: const AlwaysScrollableScrollPhysics(
                            parent: BouncingScrollPhysics(),
                          ),
                          children: [
                            _buildEmptyState(),
                          ],
                        );
                      }

                      return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
                        itemCount: filteredList.length,
                        itemBuilder: (context, index) {
                          return _buildWorkOrderCard(filteredList[index]);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBackground(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final headerHeight = topPadding + 116.0;

    return Container(
      height: headerHeight,
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
            top: -100,
            right: -80,
            child: _circle(280, Colors.white.withOpacity(0.05)),
          ),
          Positioned(
            top: -60,
            right: -40,
            child: _circle(180, Colors.white.withOpacity(0.06)),
          ),
          Positioned(
            top: -140,
            right: -120,
            child: _ring(380, Colors.white.withOpacity(0.07)),
          ),
          Positioned(
            top: -100,
            right: -80,
            child: _ring(280, Colors.white.withOpacity(0.08)),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
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
            widget.operation,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: Colors.white,
              letterSpacing: -0.4,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatisticsCard() {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatisticColumn(
              count: _openCount,
              label: 'Open',
              color: const Color(0xFF0C6ECB),
              filterKey: 'Open',
            ),
          ),
          Container(width: 1, height: 44, color: const Color(0xFFE2E8F0)),
          Expanded(
            child: _buildStatisticColumn(
              count: _inProgressCount,
              label: 'In progress',
              color: const Color(0xFFD97706),
              filterKey: 'Work In Progress',
            ),
          ),
          Container(width: 1, height: 44, color: const Color(0xFFE2E8F0)),
          Expanded(
            child: _buildStatisticColumn(
              count: _completedCount,
              label: 'Completed',
              color: const Color(0xFF16A34A),
              filterKey: 'Completed',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticColumn({
    required int count,
    required String label,
    required Color color,
    required String filterKey,
  }) {
    final isSelected = selectedFilter.toLowerCase() == filterKey.toLowerCase();

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // If already selected, tap toggles back to 'All'
          if (isSelected) {
            // _onFilterSelected('All');
          } else {
            _onFilterSelected(filterKey);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              count.toString().padLeft(2, '0'),
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: color,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    color: isSelected ? color : const Color(0xFF475569),
                  ),
                ),
                if (isSelected) ...[
                  const SizedBox(width: 4),
                  Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndFilterRow() {
    return Row(
      children: [
        // Search Bar (White container)
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD3DEEC),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04244C).withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value.trim();
                });
              },
              onSubmitted: (value) {
                setState(() {
                  searchQuery = value.trim();
                });
              },
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Color(0xFF131A2A),
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF0C6ECB),
                  size: 22,
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(
                          Icons.close_rounded,
                          color: Color(0xFF64748B),
                          size: 18,
                        ),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchQuery = '';
                          });
                        },
                      )
                    : null,
                hintText: 'Search MFG / WO',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF64748B),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // Filter Button with PopupMenu to choose All, Open, Work In Progress, Completed
        PopupMenuButton<String>(
          tooltip: 'Filter records',
          initialValue: selectedFilter,
          offset: const Offset(0, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.12),
          onSelected: (value) => _onFilterSelected(value),
          itemBuilder: (context) => [
            _buildFilterMenuItem('All', 'All'),
            _buildFilterMenuItem('Open', 'Open'),
            _buildFilterMenuItem('Work In Progress', 'Work In Progress'),
            _buildFilterMenuItem('Completed', 'Completed'),
          ],
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD3DEEC),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF04244C).withOpacity(0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.tune_rounded,
                  color: Color(0xFF0C6ECB),
                  size: 22,
                ),
                if (selectedFilter != 'Open')
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD97706),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildFilterMenuItem(String value, String label) {
    final bool isSelected = selectedFilter.toLowerCase() == value.toLowerCase();

    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            isSelected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_off_rounded,
            size: 18,
            color:
                isSelected ? const Color(0xFF0C6ECB) : const Color(0xFF94A3B8),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected
                  ? const Color(0xFF0C6ECB)
                  : const Color(0xFF131A2A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkOrderCard(WorkOrderItem order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF04244C).withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (order.status != 'Completed') {
              AppRoute.scanMachine.push(
                context,
                extra: {
                  'name': widget.operation,
                  'order': order,
                  'filter': selectedFilter,
                },
              ).then((_) {
                if (mounted) _fetchWorkOrders();
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Leading File Icon + Work Order Number & Item + Status Badge
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // File Icon Box
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE5F1FC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.description_outlined,
                        color: Color(0xFF0C6ECB),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    // Work Order Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            order.workOrder,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0A2540),
                              letterSpacing: -0.2,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            order.productionItem.isNotEmpty
                                ? order.productionItem
                                : '--',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF64748B),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Status Badge
                    _buildStatusBadge(order.status),
                  ],
                ),
                const SizedBox(height: 12),
                // Subtle horizontal divider
                const Divider(
                  height: 1,
                  thickness: 1,
                  color: Color(0xFFF1F5F9),
                ),
                const SizedBox(height: 12),
                // Bottom Row: Calendar Date / Name + Quantity
                Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 14,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat('dd MMM yyyy').format(DateTime.now()),
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF475569),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        order.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF475569),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (order.forQnty != null) ...[
                      Text(
                        'Qty: ${order.forQnty?.toInt() ?? 0} (${order.totalComplQnty.toInt()})',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF0C6ECB),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color bgColor;
    Color textColor;
    String displayStatus;

    final s = status.toLowerCase();
    if (s == 'open') {
      bgColor = const Color(0xFFE1EDFA);
      textColor = const Color(0xFF0C6ECB);
      displayStatus = 'Open';
    } else if (s.contains('progress')) {
      bgColor = const Color(0xFFFEF3C7);
      textColor = const Color(0xFFB45309);
      displayStatus = 'In progress';
    } else if (s == 'completed') {
      bgColor = const Color(0xFFDCFCE7);
      textColor = const Color(0xFF166534);
      displayStatus = 'Completed';
    } else {
      bgColor = const Color(0xFFF1F5F9);
      textColor = const Color(0xFF475569);
      displayStatus = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        displayStatus,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w700,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 48,
              color: Color(0xFF94A3B8),
            ),
            const SizedBox(height: 12),
            Text(
              searchQuery.isNotEmpty
                  ? 'No work orders matching "$searchQuery"'
                  : (selectedFilter == 'All'
                      ? 'No work orders found'
                      : 'No $selectedFilter work orders'),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
              ),
            ),
          ],
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
