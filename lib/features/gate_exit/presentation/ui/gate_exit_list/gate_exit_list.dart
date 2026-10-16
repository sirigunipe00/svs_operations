import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';
import 'package:svs_operations/features/gate_exit/model/gate_exit.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/gate_exit_filter.dart';
import 'package:svs_operations/features/gate_exit/presentation/widgets/gate_exit_widget.dart';
import 'package:svs_operations/widgets/infinite_list_widget.dart';

class GateExitListScrn extends StatefulWidget {
  const GateExitListScrn({super.key});

  @override
  State<GateExitListScrn> createState() => _GateExitListScrnState();
}

class _GateExitListScrnState extends State<GateExitListScrn> {
  late final GateExitFilterCubit _filterCubit;
  late final GateExitsCubit _exitsCubit;

  @override
  void initState() {
    super.initState();
    _filterCubit = context.read<GateExitFilterCubit>();
    _exitsCubit = context.read<GateExitsCubit>();

    // When screen is opened/re-opened, reset filters and fetch fresh unfiltered data
    _resetAndFetch();
  }

  void _resetAndFetch() {
    _filterCubit.reset();
    _exitsCubit.fetchInitial(PageListFilters.initial());
  }

  @override
  void dispose() {
    // When leaving this screen, reset the filter so it doesn't linger
    _filterCubit.reset();
    _exitsCubit.fetchInitial(PageListFilters.initial());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterState = context.watch<GateExitFilterCubit>().state;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        _filterCubit.reset();
        _exitsCubit.fetchInitial(PageListFilters.initial());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Column(
          children: [
            // Navy Gradient Header with Rings, Search, and Status Filters
            GateHeader(
              title: 'Gate Exit',
              onBack: () {
                _filterCubit.reset();
                _exitsCubit.fetchInitial(PageListFilters.initial());
                Navigator.of(context).maybePop();
              },
              searchWidget: GateSearchBar(
                initial: filterState.query,
                hintText: 'Search',
                onSearch: (value) {
                  _filterCubit.onSearch(value);
                  fetchInital(context);
                },
                onClear: () {
                  _filterCubit.onSearch(null);
                  fetchInital(context);
                },
              ),
              filterWidget: GateStatusFilterChips(
                statuses: const ['All', 'Draft', 'Submitted', 'Cancelled'],
                selectedStatus: filterState.status ?? 'All',
                onSelected: (status) {
                  _filterCubit.onChangeStatus(status);
                  fetchInital(context);
                },
              ),
            ),

            // Infinite List
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async => fetchInital(context),
                child: InfiniteListViewWidget<GateExitsCubit, GateExit>(
                  childBuilder: (context, exit) => GateExitWidget(
                    gateExit: exit,
                    onTap: () {
                      AppRoute.newGateExit.push<bool?>(
                        context,
                        extra: exit.name,
                      ).then((_) {
                        if (context.mounted) {
                          fetchInital(context);
                        }
                      });
                    },
                  ),
                  fetchInitial: () => fetchInital(context),
                  fetchMore: () => fetchMore(context),
                  emptyListText: 'No Gate Exits Found',
                ),
              ),
            ),
          ],
        ),

        // Bottom Action Button "New gate exit +"
        bottomNavigationBar: GatePrimaryButton(
          label: 'New gate exit +',
          onPressed: () {
            AppRoute.newGateExit.push<bool?>(context).then((_) {
              if (context.mounted) {
                fetchInital(context);
              }
            });
          },
        ),
      ),
    );
  }

  void fetchInital(BuildContext context) {
    final filter = context.read<GateExitFilterCubit>().state;
    context.cubit<GateExitsCubit>().fetchInitial(filter);
  }

  void fetchMore(BuildContext context) {
    final filter = context.read<GateExitFilterCubit>().state;
    context.cubit<GateExitsCubit>().fetchMore(filter);
  }
}
