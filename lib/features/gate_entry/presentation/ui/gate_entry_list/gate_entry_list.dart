import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';
import 'package:svs_operations/features/gate_entry/model/gate_entry.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_entry_widget.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';
import 'package:svs_operations/widgets/infinite_list_widget.dart';

class GateEntryListScrn extends StatefulWidget {
  const GateEntryListScrn({super.key});

  @override
  State<GateEntryListScrn> createState() => _GateEntryListScrnState();
}

class _GateEntryListScrnState extends State<GateEntryListScrn> {
  late final GateEntryFilterCubit _filterCubit;
  late final GateEntriesCubit _entriesCubit;

  @override
  void initState() {
    super.initState();
    _filterCubit = context.read<GateEntryFilterCubit>();
    _entriesCubit = context.read<GateEntriesCubit>();

    // When screen is opened/re-opened, reset filters and fetch fresh unfiltered data
    _resetAndFetch();
  }

  void _resetAndFetch() {
    _filterCubit.reset();
    _entriesCubit.fetchInitial(PageListFilters.initial());
  }

  @override
  void dispose() {
    // When leaving this screen, reset the filter so it doesn't linger
    _filterCubit.reset();
    _entriesCubit.fetchInitial(PageListFilters.initial());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterState = context.watch<GateEntryFilterCubit>().state;

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) {
        _filterCubit.reset();
        _entriesCubit.fetchInitial(PageListFilters.initial());
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        body: Column(
          children: [
            // Navy Gradient Header with Rings, Search, and Status Filters
            GateHeader(
              title: 'Gate Entry',
              onBack: () {
                _filterCubit.reset();
                _entriesCubit.fetchInitial(PageListFilters.initial());
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
                child: InfiniteListViewWidget<GateEntriesCubit, GateEntry>(
                  childBuilder: (context, entry) => GateEntryWidget(
                    gateEntry: entry,
                    onTap: () {
                      AppRoute.newGateEntry.push<bool?>(
                        context,
                        extra: {
                          'gate_entry_name': entry.name,
                          'po_number': entry.poNumber,
                        },
                      ).then((_) {
                        if (context.mounted) {
                          fetchInital(context);
                        }
                      });
                    },
                  ),
                  fetchInitial: () => fetchInital(context),
                  fetchMore: () => fetchMore(context),
                  emptyListText: 'No ${filterState.status} records found',
                ),
              ),
            ),
          ],
        ),

        // Bottom Action Button "New gate entry +"
        bottomNavigationBar: GatePrimaryButton(
          label: 'New gate entry +',
          onPressed: () {
            AppRoute.newGateEntry.push<bool?>(context).then((_) {
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
    final filter = context.read<GateEntryFilterCubit>().state;
    context.cubit<GateEntriesCubit>().fetchInitial(filter);
  }

  void fetchMore(BuildContext context) {
    final filter = context.read<GateEntryFilterCubit>().state;
    context.cubit<GateEntriesCubit>().fetchMore(filter);
  }
}
