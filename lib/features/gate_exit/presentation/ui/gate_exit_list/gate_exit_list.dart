import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/app/widgets/app_page_view2.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_exit/model/gate_exit.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/gate_exit_filter.dart';
import 'package:svs_operations/features/gate_exit/presentation/widgets/gate_exit_widget.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/styles/icons.dart';
import 'package:svs_operations/widgets/infinite_list_widget.dart';

class GateExitListScrn extends StatelessWidget {
  const GateExitListScrn({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPageView2<GateExitFilterCubit>(
      mode: PageMode2.gateexit,
      scaffoldBg: AppIcons.bgFrame2.path,
      backgroundColor: AppColors.shyMoment,
      onNew: () => AppRoute.newGateExit.push(context),
      onUpdateQuery: (value) {
        context.cubit<GateExitFilterCubit>().onSearch(value);
        fetchInital(context);
      },
      onUpdateStatus: (value) {
        context.cubit<GateExitFilterCubit>().onChangeStatus(value);
        fetchInital(context);
      },
      status: const ['All','Draft', 'Submitted','Cancelled'],
      child: InfiniteListViewWidget<GateExitsCubit, GateExit>(
        childBuilder: (context, exit) => GateExitWidget(
          gateExit: exit,
          onTap: () =>
            AppRoute.newGateExit.push<bool?>(context, extra: exit.name),
          
        ),
        fetchInitial: () => fetchInital(context),
        fetchMore: () => fetchMore(context),
        emptyListText: 'No GateExits Found',
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
