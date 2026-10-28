import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/core/model/page_list_filters.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_exit/presentation/bloc/create_gate_exit/create_gate_exit_cubit.dart';
import 'package:svs_operations/features/gate_exit/presentation/ui/create/widget/gate_exit_form_widget.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class NewGateExit extends StatefulWidget {
  const NewGateExit({super.key});

  @override
  State<NewGateExit> createState() => _NewGateExitState();
}

class _NewGateExitState extends State<NewGateExit> {
  @override
  Widget build(BuildContext context) {
    final gateExitState = context.watch<CreateGateExitCubit>().state;
    final form = gateExitState.form;
    final status = form.status;
    final name = form.name;
    final isNew = gateExitState.view == GateExitView.create;
    final isCompleted = gateExitState.view == GateExitView.completed;

    final headerTitle = isNew ? 'New Gate Exit' : name;
    final headerTag = isNew ? null : status;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: BlocListener<CreateGateExitCubit, CreateGateExitState>(
        listener: (_, state) async {
          if (state.isSuccess && state.successMsg.isNotNull) {
            AppDialog.showSuccessDialog(
              context,
              content: state.successMsg.valueOrEmpty,
              onTapDismiss: context.exit,
            );
            context.cubit<GateExitsCubit>().fetchInitial(PageListFilters.initial());
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
            context.cubit<CreateGateExitCubit>().errorHandled();
            return;
          }
        },
        child: Column(
          children: [
            // Navy Gradient Header
            GateHeader(
              title: headerTitle ?? '',
              tagText: headerTag,
              onBack: () => Navigator.of(context).maybePop(),
            ),

            // Form Body
            Expanded(
              child: BlocConsumer<GateExitDetails, GateExitDetailsState>(
                listener: (_, state) {
                  state.maybeWhen(
                    success: (data) {
                      context.cubit<CreateGateExitCubit>().initDetails(data);
                      setState(() {});
                    },
                    orElse: () {},
                  );
                },
                builder: (_, state) {
                  return state.maybeWhen(
                    orElse: () => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GateExitFormWidget(key: ValueKey(status)),
                    ),
                    loading: () => const Center(child: LoadingIndicator()),
                    failure: (failure) => AppErrorWidget(error: failure.error, isRefresh: true,),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Action Button "Save gate exit ✓"
      bottomNavigationBar: !isCompleted
          ? GatePrimaryButton(
              label: isNew ? 'Save gate exit ✓' : 'Submit gate exit ✓',
              isLoading: gateExitState.isLoading,
              onPressed: () {
                context.cubit<CreateGateExitCubit>().save();
              },
            )
          : null,
    );
  }
}
