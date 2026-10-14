import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/model/purchase_order.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/styles/app_colors.dart';
import 'package:svs_operations/widgets/inputs/image_selection_widget1.dart';
import 'package:svs_operations/widgets/widgets.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';

class GateEntryFormWidget extends StatefulWidget {
  const GateEntryFormWidget({super.key});

  @override
  State<GateEntryFormWidget> createState() => _GateEntryFormWidgetState();
}

class _GateEntryFormWidgetState extends State<GateEntryFormWidget> {
  bool? isJobWork; // checkbox value
  bool? isJobWorkEnabled;

  @override
  Widget build(BuildContext context) {
    final formState = context.read<NewGateEntryCubit>().state;
    final isCreating = formState.view == GateEntryView.create;
    final isCompleted = formState.view == GateEntryView.completed;
    final form = formState.form;

    return SpacedColumn(
      margin: const EdgeInsets.all(12.0),
      defaultHeight: 8,
      children: [
        BlocBuilder<PurchaseOrders, PurchaseOrdersState>(
          builder: (_, state) {
            final items = state.maybeWhen(
              orElse: () => <PurchaseOrder>[],
              success: (data) => data,
            );
            return AppDropDownWidget<PurchaseOrder>(
              title: 'PO Number',
              items: items,
              readOnly: isCompleted,
              hint: 'Select PO Number',
              isMandatory: true,
              headerBuilder: (_, item, __) => Text(item.poNumber),
              defaultSelection: form.poNumber.containsValidValue
                  ? PurchaseOrder(
                      name: '',
                      poNumber: form.poNumber!,
                      date: '',
                      totalAmount: 0.0)
                  : null,
              futureRequest: (query) => _onSearch(items, query),
              listItemBuilder: (_, item, isSelected, p3) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.poNumber,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(item.name),
                  Row(
                    children: [
                      Text(item.date),
                      const SizedBox(width: 4.0),
                      Text(item.totalAmount.toString()),
                    ],
                  ),
                ],
              ),
              onSelected: (order) {
                if (order.isNull) {
                  return;
                }

                context.cubit<ItemNameCubit>().request(order!.poNumber);
                context.cubit<NewGateEntryCubit>().onValueChanged(
                      poNumber: order.poNumber,
                    );
              },
            );
          },
        ),
        // BlocBuilder<ItemNameCubit, ItemNameCubitState>(
        //   builder: (context, itemState) {
        //     bool isEnabled = false;

        //     itemState.maybeWhen(
        //       success: (items) {
        //         isEnabled = items.any((item) {
        //           final name = item.itemName.toLowerCase();
        //           return name.contains('job work') ||
        //               name.contains('jobwork') ||
        //               name.contains('jw');
        //         });

        //         // auto set value
        //         WidgetsBinding.instance.addPostFrameCallback((_) {
        //           context
        //               .cubit<NewGateEntryCubit>()
        //               .onValueChanged(isJobWork: isEnabled ? 1 : 0);
        //         });
        //       },
        //       orElse: () {},
        //     );

        //     return _buildCheckbox(context, isEnabled);
        //   },
        // ),
        InputField(
          title: 'Vechicle Number',
          readOnly: isCompleted,
          isRequired: true,
          initialValue: form.vehicleNo,
          inputFormatters: [UpperCaseTextFormatter()],
          borderColor: AppColors.marigoldDDust,
          onChanged: (vehicleNum) {
            context
                .cubit<NewGateEntryCubit>()
                .onValueChanged(vehicleNo: vehicleNum);
          },
        ),
        Row(
          children: [
            Expanded(
              child: BlocBuilder<NewGateEntryCubit, NewGateEntryState>(
                buildWhen: (pv, curr) =>
                    pv.form.vehiclePhoto != curr.form.vehiclePhoto,
                builder: (_, state) {
                  return ImageSelectionWidget1(
                    title: 'Vechicle Front Photo',
                    readOnly: isCompleted,
                    key: ValueKey(state.form.vehiclePhoto),
                    borderColor: AppColors.marigoldDDust,
                    defaultVal: state.form.vehiclePhoto,
                    placeholder: const Icon(Icons.local_shipping,
                        size: 64, color: AppColors.chimneySweep),
                    onView: () {
                      final data = Pair(form.name ?? 'Vechicle Front Photo',
                          state.form.vehiclePhoto);
                      AppRoute.newGateEntryPreview.push(context, extra: data);
                    },
                    onImage: (file) {
                      if (file.isNull) {
                        context.cubit<NewGateEntryCubit>().clearVehiclePhoto();
                      } else {
                        context
                            .cubit<NewGateEntryCubit>()
                            .onValueChanged(vehiclePhoto: file);
                      }
                    },
                  );
                },
              ),
            ),
            AppSpacer.p12(),
            Expanded(
              child: BlocBuilder<NewGateEntryCubit, NewGateEntryState>(
                buildWhen: (pv, curr) =>
                    pv.form.vehicleBackPhoto != curr.form.vehicleBackPhoto,
                builder: (_, state) {
                  return ImageSelectionWidget1(
                    title: 'Vechicle Back Photo',
                    readOnly: isCompleted,
                    key: ValueKey(state.form.vehicleBackPhoto),
                    borderColor: AppColors.marigoldDDust,
                    defaultVal: state.form.vehicleBackPhoto,
                    placeholder: const Icon(Icons.local_shipping,
                        size: 64, color: AppColors.chimneySweep),
                    onView: () {
                      final data = Pair(form.name ?? 'Vechicle Back Photo',
                          state.form.vehicleBackPhoto);
                      AppRoute.newGateEntryPreview.push(context, extra: data);
                    },
                    onImage: (file) {
                      if (file.isNull) {
                        context
                            .cubit<NewGateEntryCubit>()
                            .clearVehicleBackPhoto();
                      } else {
                        context
                            .cubit<NewGateEntryCubit>()
                            .onValueChanged(vehicleBackPhoto: file);
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
        BlocBuilder<NewGateEntryCubit, NewGateEntryState>(
          buildWhen: (pv, curr) =>
              pv.form.vendorInvPhoto != curr.form.vendorInvPhoto,
          builder: (context, state) {
            return ImageSelectionWidget1(
              title: 'Vendor Invoice Photo',
              readOnly: isCompleted,
              key: ValueKey(state.form.vendorInvPhoto),
              borderColor: AppColors.marigoldDDust,
              defaultVal: state.form.vendorInvPhoto,
              placeholder: const Icon(Icons.description,
                  size: 64, color: AppColors.chimneySweep),
              onView: () {
                final data = Pair(form.name ?? 'Vendor Invoice Photo',
                    state.form.vendorInvPhoto);
                AppRoute.newGateEntryPreview.push(context, extra: data);
              },
              onImage: (file) {
                if (file.isNull) {
                  context.cubit<NewGateEntryCubit>().clearInvPhoto();
                } else {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(invoicePhoto: file);
                }
              },
            );
          },
        ),
        InputField(
          title: 'Vendor Invoice Number',
          readOnly: isCompleted,
          isRequired: true,
          initialValue: form.vendorInvNo,
          borderColor: AppColors.marigoldDDust,
          onChanged: (invNumber) {
            context
                .cubit<NewGateEntryCubit>()
                .onValueChanged(vendorInvNo: invNumber);
          },
        ),
        DateSelectionField(
          title: 'Vendor Invoice Date',
          isRequired: true,
          initialValue: form.invoiceDate,
          readOnly: isCompleted,
          firstDate: DFU.now().subtract(const Duration(days: 60)),
          lastDate: DFU.now(),
          onDateSelect: (date) {
            final formattedDate = DFU.friendlyFormat(date);
            context
                .cubit<NewGateEntryCubit>()
                .onValueChanged(invoiceDate: formattedDate);
          },
          borderColor: AppColors.marigoldDDust,
          suffixIcon: const Icon(Icons.calendar_month_outlined,
              color: AppColors.chimneySweep),
        ),
        InputField(
          title: 'Vendor Invoice Quantity',
          readOnly: isCompleted,
          initialValue: form.invoiceQty,
          borderColor: AppColors.marigoldDDust,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (qty) {
            context.cubit<NewGateEntryCubit>().onValueChanged(invoiceQty: qty);
          },
        ),
        InputField(
          title: 'Invoice Amount',
          readOnly: isCompleted,
          initialValue: form.invoiceAmt,
          borderColor: AppColors.marigoldDDust,
          inputType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (amount) {
            context
                .cubit<NewGateEntryCubit>()
                .onValueChanged(invoiceAmt: amount);
          },
        ),
        DateSelectionField(
          title: 'Gate Entry Date',
          filled: true,
          initialValue: form.entryDate,
          firstDate: DFU.now(),
          lastDate: DFU.now(),
          onDateSelect: (date) {},
          readOnly: true,
          isRequired: true,
          borderColor: AppColors.marigoldDDust,
          suffixIcon:
              const Icon(Icons.calendar_month_outlined, color: AppColors.black),
        ),
        InputField(
          title: 'Remarks',
          readOnly: isCompleted,
          initialValue: form.remarks,
          borderColor: AppColors.marigoldDDust,
          minLines: 3,
          onChanged: (remarks) {
            context.cubit<NewGateEntryCubit>().onValueChanged(remarks: remarks);
          },
        ),
        if (!isCompleted) ...[
          BlocBuilder<NewGateEntryCubit, NewGateEntryState>(
            builder: (_, state) => AppButton(
              label: isCreating ? 'Save' : 'Submit',
              isLoading: state.isLoading,
              bgColor: AppColors.haintBlue,
              margin: const EdgeInsets.all(12.0),
              onPressed: context.cubit<NewGateEntryCubit>().save,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildCheckbox(BuildContext context, bool isEnabled) {
    return BlocBuilder<NewGateEntryCubit, NewGateEntryState>(
      builder: (context, state) {
        return CheckboxListTile(
          dense: true,
          visualDensity: const VisualDensity(vertical: -4),
          title: const Text(
            'Is Job Work',
            style: TextStyle(color: Colors.black),
          ),
          value: isEnabled,
          onChanged: isEnabled
              ? (value) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(isJobWork: value == true ? 1 : 0);
                }
              : null, // disabled
        );
      },
    );
  }

  Future<List<PurchaseOrder>> _onSearch(
      List<PurchaseOrder> data, String query) async {
    final filterData = data.where((e) => e.poNumber.contains(query)).toList();
    return filterData;
  }
}
