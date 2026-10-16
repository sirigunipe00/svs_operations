import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/gate_entry_filter.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';
import 'package:svs_operations/features/gate_entry/presentation/ui/create/widget/gate_entry_form_widget.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';
import 'package:svs_operations/widgets/app_error_widget.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';
import 'package:svs_operations/widgets/loading_indicator.dart';

class NewGateEntry extends StatefulWidget {
  const NewGateEntry({super.key});

  @override
  State<NewGateEntry> createState() => _NewGateEntryState();
}

class _NewGateEntryState extends State<NewGateEntry> {
  @override
  Widget build(BuildContext context) {
    final gateEntryState = context.watch<NewGateEntryCubit>().state;
    final form = gateEntryState.form;
    final status = form.status;
    final name = form.name;
    final isNew = gateEntryState.view == GateEntryView.create;
    final isCompleted = gateEntryState.view == GateEntryView.completed;

    final headerTitle = isNew ? 'New Gate Entry' : name;
    final headerTag = isNew ? null : status;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: BlocListener<NewGateEntryCubit, NewGateEntryState>(
        listener: (_, state) async {
          if (state.isSuccess && state.successMsg.isNotNull) {
            AppDialog.showSuccessDialog(
              context,
              title: 'Success',
              content: state.successMsg.valueOrEmpty,
              onTapDismiss: context.exit,
            ).then((_) {
              if (!context.mounted) return;
              final filter = context.read<GateEntryFilterCubit>().state;
              context
                ..cubit<GateEntriesCubit>().fetchInitial(filter)
                ..cubit<NewGateEntryCubit>().errorHandled();
            });
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
                    orElse: () => SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: GateEntryFormWidget(key: ValueKey(status)),
                    ),
                    loading: () => const Center(child: LoadingIndicator()),
                    failure: (failure) => AppErrorWidget(error: failure.error),
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // Bottom Action Button "Save gate entry ✓"
      bottomNavigationBar: !isCompleted
          ? GatePrimaryButton(
              label: isNew ? 'Save gate entry ✓' : 'Submit gate entry ✓',
              isLoading: gateEntryState.isLoading,
              onPressed: () {
                context.cubit<NewGateEntryCubit>().save();
              },
            )
          : null,
    );
  }
}
