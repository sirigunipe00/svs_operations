import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/app/widgets/app_page_view2.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/model/gate_entry.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_entry_widget.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/icons.dart';
import 'package:svs_operations/widgets/infinite_list_widget.dart';

class GateEntryListScrn extends StatelessWidget {
  const GateEntryListScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageView2<GateEntryFilterCubit>(
      mode: PageMode2.gateentry,
      scaffoldBg: AppIcons.bgFrame1.path,
      backgroundColor: AppColors.marigoldDDust,
      onNew: () => AppRoute.newGateEntry.push<bool?>(context),
      onUpdateQuery: (value) {
        context.cubit<GateEntryFilterCubit>().onSearch(value);
        fetchInital(context);
      },
      onUpdateStatus: (value) {
        context.cubit<GateEntryFilterCubit>().onChangeStatus(value);
        fetchInital(context);
      },
      status: const ['All','Draft', 'Submitted','Cancelled'],
      child: InfiniteListViewWidget<GateEntriesCubit, GateEntry>(
        childBuilder: (context, entry) => GateEntryWidget(
          gateEntry: entry,
          onTap: () =>
              AppRoute.newGateEntry.push<bool?>(context, extra: {'gate_entry_name': entry.name, 'po_number': entry.poNumber}),
        ),
        fetchInitial: () => fetchInital(context),
        fetchMore: () => fetchMore(context),
        emptyListText: 'No GateEntries Found',
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
