import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';
import 'package:svs_operations/features/gate_entry/presentation/ui/create/widget/gate_entry_form_widget.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';
import 'package:svs_operations/widgets/widgets.dart';

class NewGateEntry extends StatefulWidget {
  const NewGateEntry({super.key});

  @override
  State<NewGateEntry> createState() => _NewGateEntryState();
}

class _NewGateEntryState extends State<NewGateEntry> {
  @override
  Widget build(BuildContext context) {
    final gateEntryState = context.read<NewGateEntryCubit>().state;
    final form = gateEntryState.form;
    final status = form.status;
    final name = form.name;

    final isNew = gateEntryState.view == GateEntryView.create;
    return Scaffold(
      appBar: isNew
          ? const SimpleAppBar(title: 'New Gate Entry')
          : TitleStatusAppBar(
              title: 'Gate Entry',
              docNo: name.valueOrEmpty,
              status: status.valueOrEmpty,
              textColor: AppColors.marigoldDDust,
            ) as PreferredSizeWidget,
      body: BlocListener<NewGateEntryCubit, NewGateEntryState>(
        listener: (_, state) async {
          if (state.isSuccess && state.successMsg.isNotNull) {
            AppDialog.showSuccessDialog(
              context,
              title: 'Success',
              content: state.successMsg.valueOrEmpty,
              onTapDismiss: context.exit,
            ).then(
              (_){
                if (!context.mounted) return;
                final filter = context.read<GateEntryFilterCubit>().state;
                context
                  ..cubit<GateEntriesCubit>().fetchInitial(filter)
                  ..cubit<NewGateEntryCubit>().errorHandled();
              }
            );
            // context.cubit<GateEntriesCubit>().fetchInitial();
            setState(() {});
          }
          if (state.error.isNotNull) {
            await AppDialog.showErrorDialog(
              context,
              title: state.error!.title,
              content: state.error!.error,
              onTapDismiss: context.exit,
            );
            if (!context.mounted) return;
            context.cubit<NewGateEntryCubit>().errorHandled();
            return;
          }
        },
        child: BlocConsumer<GateEntryDetails, GateEntryDetailsState>(
          listener: (_, state) {
            state.maybeWhen(
              success: (data) {
                context.cubit<NewGateEntryCubit>().initDetails(data);
                setState(() {});
              },
              orElse: () {},
            );
          },
          builder: (_, state) {
            return state.maybeWhen(
              orElse: () => SingleChildScrollView(child: GateEntryFormWidget(key: ValueKey(status))),
              loading: () => const Center(child: LoadingIndicator()),
              failure: (failure) => AppErrorWidget(error: failure.error),
            );
          },
        ),
      ),
    );
  }
}
