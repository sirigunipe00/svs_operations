import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/core/utils/date_format_util.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class OperationsScreen extends StatefulWidget {
  final List<String> sectionRoles;
  const OperationsScreen({super.key, required this.sectionRoles});

  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> {
  int selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    print('operations screennn...:');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations'),
      ),
      backgroundColor: const Color(0xFFF7F9FB),
      body: Column(
        children: [
          _buildTabs(),
          BlocBuilder<GetUserOperations, GetUserOperationsState>(
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () => const SizedBox(),
                loading: () => const Center(child: LoadingIndicator()),
                success: (data) {
                  final selectedRole = widget.sectionRoles.isNotEmpty
                      ? widget.sectionRoles[selectedTabIndex]
                      : '';

                  final filteredOperations =
                      data.data[selectedRole] ?? <String>[];

                  return Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: filteredOperations.length,
                      separatorBuilder: (_, __) => const Divider(
                        height: 1,
                        thickness: 1,
                        color: Color(0xFFE1E7EF),
                      ),
                      itemBuilder: (context, index) {
                        final operation = filteredOperations[index];
                        return _buildOperationItem(operation);
                      },
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Row(
      children: List.generate(
        widget.sectionRoles.length,
        (index) {
          final role = widget.sectionRoles[index];

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
              child: _buildTab(
                title: role,
                index: index,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTab({
    required String title,
    required int index,
  }) {
    final bool selected = selectedTabIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTabIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF0F6FF) : Colors.white,
          border: Border(
            bottom: BorderSide(
              color: selected ? const Color(0xFF2187CC) : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: selected
                    ? const Color(0xFF2187CC)
                    : const Color(0xFF637592),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOperationItem(String operation) {
    return InkWell(
      onTap: () {
        AppRoute.tcList.push(context, extra: operation);
      },
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      operation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFF8FA1B9),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OperationItem {
  final String title;
  final String type;
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  OperationItem({
    required this.title,
    required this.type,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}

String dayOfTimeGreeting() {
  final currHour = DFU.now().hour;
  return switch (currHour) {
    < 12 => 'Good Morning,',
    > 12 && <= 16 => 'Good Afternoon,',
    > 16 && < 20 => 'Good Evening,',
    >= 20 => 'Good Night,',
    _ => '',
  };
}
