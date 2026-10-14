import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/app_router/app_route.dart';
import 'package:svs_operations/features/tube_cutting/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/styles/icons.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class OperationsScreen extends StatefulWidget {
  final List<String> sectionRoles;
  const OperationsScreen({super.key, required this.sectionRoles});

  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> {
  int selectedTabIndex = 0;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDF2F9),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: BlocBuilder<GetUserOperations, GetUserOperationsState>(
              builder: (context, state) {
                return state.maybeWhen(
                  orElse: () => const SizedBox(),
                  loading: () => const Center(child: LoadingIndicator()),
                  success: (data) {
                    final selectedRole = widget.sectionRoles.isNotEmpty
                        ? widget.sectionRoles[selectedTabIndex]
                        : '';

                    final allOperations =
                        data.data[selectedRole] ?? <String>[];

                    final filteredOperations = _searchQuery.isEmpty
                        ? allOperations
                        : allOperations
                            .where((op) => op
                                .toLowerCase()
                                .contains(_searchQuery.toLowerCase()))
                            .toList();

                    return Column(
                      children: [
                        // Search bar
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                          child: _buildSearchBar(),
                        ),
                        // Operations list
                        Expanded(
                          child: filteredOperations.isEmpty
                              ? _buildEmptyState()
                              : ListView.builder(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  itemCount: filteredOperations.length,
                                  itemBuilder: (context, index) {
                                    final operation =
                                        filteredOperations[index];
                                    return _buildOperationCard(operation);
                                  },
                                ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
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
          // Decorative background circles and rings
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
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button + Title
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
                      const Text(
                        'Operations',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  // Segmented Tabs (SFG / FG)
                  if (widget.sectionRoles.isNotEmpty) _buildTabs(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.14),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withOpacity(0.22),
          width: 1.2,
        ),
      ),
      child: Row(
        children: List.generate(
          widget.sectionRoles.length,
          (index) {
            final role = widget.sectionRoles[index];
            final bool isSelected = selectedTabIndex == index;

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedTabIndex = index;
                  });
                },
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      role,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight:
                            isSelected ? FontWeight.w800 : FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF0C6ECB)
                            : Colors.white.withOpacity(0.9),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
        controller: _searchController,
        onChanged: (val) {
          setState(() {
            _searchQuery = val.trim();
          });
        },
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Color(0xFF131A2A),
        ),
        decoration: InputDecoration(
          hintText: 'Search operations',
          hintStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Color(0xFF64748B),
          ),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: Color(0xFF0C6ECB),
            size: 22,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Color(0xFF64748B),
                    size: 18,
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildOperationCard(String operation) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
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
            AppRoute.tcList.push(context, extra: operation);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Row(
              children: [
                _buildOperationIcon(operation),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    operation,
                    style: const TextStyle(
                      fontSize: 15.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF131A2A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F1FC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF0C6ECB),
                    size: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOperationIcon(String operation) {
    final op = operation.toLowerCase();

    Color bgColor;
    Widget iconWidget;

    if (op.contains('tube') || op.contains('cutting')) {
      bgColor = const Color(0xFFFFEFE6);
      iconWidget = AppIcons.tubeCutting.toWidget(width: 24, height: 24);
    } else if (op.contains('braz')) {
      bgColor = const Color(0xFFE8F3FD);
      iconWidget = AppIcons.brazingIcon.toWidget(width: 24, height: 24);
    } else if (op.contains('spin')) {
      bgColor = const Color(0xFFFAE8F7);
      iconWidget = AppIcons.spinningIcon.toWidget(width: 24, height: 24);
    } else if (op.contains('mesh') || op.contains('insert')) {
      bgColor = const Color(0xFFE6F0FD);
      iconWidget = AppIcons.meshInsertion.toWidget(width: 24, height: 24);
    } else if (op.contains('visual') || op.contains('inspect')) {
      bgColor = const Color(0xFFE2F4FA);
      iconWidget = AppIcons.visualInspection.toWidget(width: 24, height: 24);
    } else if (op.contains('vaccum') ||
        op.contains('vacuum') ||
        op.contains('pack')) {
      bgColor = const Color(0xFFE4F5F2);
      iconWidget = AppIcons.vaccumePacking.toWidget(width: 24, height: 24);
    } else if (op.contains('molecul')) {
      bgColor = const Color(0xFFEAE8FD);
      iconWidget = AppIcons.molecularIcon.toWidget(width: 24, height: 24);
    } else if (op.contains('qty')) {
      bgColor = const Color(0xFFFFF3E0);
      iconWidget = AppIcons.qtyInspection.toWidget(width: 24, height: 24);
    } else {
      bgColor = const Color(0xFFE8F1FC);
      iconWidget = const Icon(
        Icons.settings_suggest_rounded,
        color: Color(0xFF0C6ECB),
        size: 24,
      );
    }

    return Container(
      width: 46,
      height: 46,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(14),
      ),
      alignment: Alignment.center,
      child: iconWidget,
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2_outlined,
              size: 48,
              color: Color(0xFF94A3B8),
            ),
            const SizedBox(height: 12),
            Text(
              _searchQuery.isNotEmpty
                  ? 'No operations matching "$_searchQuery"'
                  : 'No operations available',
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
