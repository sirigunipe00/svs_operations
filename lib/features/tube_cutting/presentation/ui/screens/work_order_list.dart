import 'package:dartz/dartz.dart' as datrz;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/tube_cutting/model/work_order_model.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/styles/app_colors.dart';
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(
        'searchController.text.isNotEmpty..:${searchController.text.isNotEmpty}');
    return RefreshIndicator(
      onRefresh: () async {
        await context
            .cubit<WorkOrderList>()
            .request(datrz.Tuple3(widget.operation, '', selectedFilter));
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.operation,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '(${DateFormat('dd/MM/yy').format(DateTime.now())})',
                style: const TextStyle(
                  color: Color(0xFF61728D),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFF7F9FC),
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBlueHeader(),
                    BlocBuilder<WorkOrderList, WorkOrderListState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const SizedBox(),
                          success: (data) => Transform.translate(
                            offset: const Offset(0, -85),
                            child: _buildStatisticsCard(data),
                          ),
                        );
                      },
                    ),
                    Transform.translate(
                      offset: const Offset(0, -65),
                      child: Column(
                        children: [
                          _buildSearchSection(),
                          const SizedBox(height: 12),
                          BlocBuilder<WorkOrderList, WorkOrderListState>(
                            builder: (context, state) {
                              return state.maybeWhen(
                                orElse: () => const SizedBox(),
                                loading: () =>
                                    const Center(child: LoadingIndicator()),
                                failure: (failure) => AppErrorWidget(
                                  error: failure.error,
                                  onRefresh: () => context
                                      .cubit<WorkOrderList>()
                                      .request(datrz.Tuple3(widget.operation,
                                          '', selectedFilter)),
                                ),
                                success: (data) {
                                  print('suceesss.....');
                                  if (data.isEmpty) {
                                    return const Center(
                                      child: Text('No records found'),
                                    );
                                  }

                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: _buildWorkOrderCard(data[index]),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget _buildBlueHeader() {
    return SizedBox(
      height: 105,
      width: double.infinity,
      child: ClipPath(
        clipper: BlueHeaderClipper(),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF72BEF4),
                Color(0xFF198DE3),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatisticsCard(List<WorkOrderItem> data) {
    final openCount =
        data.where((item) => item.status.toLowerCase() == 'open').length;

    final inProgressCount = data
        .where((item) => item.status.toLowerCase() == 'work in progress')
        .length;

    final completedCount =
        data.where((item) => item.status.toLowerCase() == 'completed').length;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: const Color(0xFFE2E9F2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildStatistic(
              value: openCount.toString().padLeft(2, '0'),
              label: 'Open',
              valueColor: const Color(0xFFFF666B),
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatistic(
              value: inProgressCount.toString().padLeft(2, '0'),
              label: 'In-Progress',
              valueColor: AppColors.blue,
            ),
          ),
          _buildVerticalDivider(),
          Expanded(
            child: _buildStatistic(
              value: completedCount.toString().padLeft(2, '0'),
              label: 'Completed',
              valueColor: const Color(0xFF38B878),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistic({
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            height: 0.95,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          style: const TextStyle(
            // fontSize: 29,
            height: 1,
            fontWeight: FontWeight.w500,
            color: Color(0xFF10182C),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 2,
      height: 125,
      color: const Color(0xFF9DC6F1),
    );
  }

  Widget _buildSearchSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FD),
                borderRadius: BorderRadius.circular(45),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchController.text = value;
                  });
                },
                controller: searchController,
                onSubmitted: (value) {
                  context.read<WorkOrderList>().request(datrz.Tuple3(
                      widget.operation, searchController.text, selectedFilter));
                },
                style: const TextStyle(
                  color: Color(0xFF1687CC),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(
                      left: 25,
                      right: 10,
                    ),
                    child: Icon(
                      Icons.search,
                      size: 20,
                      color: Color(0xFF1687CC),
                    ),
                  ),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(
                            Icons.cancel,
                            color: Color(0xFF1687CC),
                            size: 20,
                          ),
                          onPressed: () {
                            searchController.clear();

                            setState(() {});
                            context.read<WorkOrderList>().request(
                                  datrz.Tuple3(
                                      widget.operation, '', selectedFilter),
                                );
                          },
                        )
                      : null,
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 25,
                    minHeight: 20,
                  ),
                  hintText: 'Search MFG/WO',
                  hintStyle: const TextStyle(
                    // fontSize: 27,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF1687CC),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 25),
          _buildFilterButton(),
        ],
      ),
    );
  }

  Widget _buildFilterButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFDDEAF9),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: PopupMenuButton<String>(
        tooltip: 'Filter records',
        icon: const Icon(
          Icons.tune,
          size: 28,
          color: Color(0xFFFF6633),
        ),
        initialValue: selectedFilter,
        onSelected: (value) {
          setState(() {
            selectedFilter = value;
          });
          context.read<WorkOrderList>().request(
                datrz.Tuple3(widget.operation, '', selectedFilter),
              );

          // Apply the selected filter here.
          // Example: fetchRecords(status: selectedFilter);
        },
        itemBuilder: (context) => [
          _buildFilterMenuItem('Open'),
          _buildFilterMenuItem('Work In Progress'),
          _buildFilterMenuItem('Completed'),
        ],
      ),
    );
  }

  PopupMenuItem<String> _buildFilterMenuItem(String value) {
    return PopupMenuItem<String>(
      value: value,
      child: Row(
        children: [
          Icon(
            selectedFilter == value
                ? Icons.radio_button_checked
                : Icons.radio_button_unchecked,
            size: 20,
            color:
                selectedFilter == value ? const Color(0xFFFF6633) : Colors.grey,
          ),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildWorkOrderCard(WorkOrderItem order) {
    return InkWell(
      onTap: () {
        if (order.status != 'Completed') {
          AppRoute.scanMachine
              .push(context, extra: {'name': widget.operation, 'order': order});
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
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
              Container(
                width: 3,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              order.workOrder,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF1687CC),
                              ),
                              softWrap: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          _buildStatusBadge(order),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Text(
                            order.name,
                            style: const TextStyle(
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
      ),
    );
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
              fontWeight: FontWeight.w500,
              color: Color(0xFF1687CC),
            ),
          ),
        ],
      ),
    );
  }
}

class WorkOrder {
  final String number;
  final String id;
  final String status;
  final String quantity;
  final String completed;
  final Color color;

  const WorkOrder({
    required this.number,
    required this.id,
    required this.status,
    required this.quantity,
    required this.completed,
    required this.color,
  });
}

class BlueHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(0, 0);

    path.lineTo(size.width, 0);

    path.lineTo(size.width, size.height - 28);

    path.lineTo(size.width * 0.70, size.height);

    path.lineTo(size.width * 0.38, size.height - 4);

    path.lineTo(0, size.height - 28);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
