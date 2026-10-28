import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/gate_entry/model/purchase_order.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/bloc_provider.dart';
import 'package:svs_operations/features/gate_entry/presentation/bloc/new_gate_entry/new_gate_entry_cubit.dart';
import 'package:svs_operations/features/gate_entry/presentation/widgets/gate_ui_components.dart';

class GateEntryFormWidget extends StatefulWidget {
  const GateEntryFormWidget({super.key});

  @override
  State<GateEntryFormWidget> createState() => _GateEntryFormWidgetState();
}

class _GateEntryFormWidgetState extends State<GateEntryFormWidget> {
  // Local controllers for driver mockup fields so user can input if desired
  // final TextEditingController _driverNameController = TextEditingController();
  final TextEditingController _vendorNameController = TextEditingController();
  final TextEditingController _driverLicenseController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();

  @override
  void dispose() {
    _vendorNameController.dispose();
    _driverLicenseController.dispose();
    _mobileNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState = context.watch<NewGateEntryCubit>().state;
    final isCompleted = formState.view == GateEntryView.completed;
    final form = formState.form;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CARD 1: VEHICLE
          GateSectionCard(
            number: '1',
            title: 'Vehicle',
            children: [
              // Vehicle Number
              GateInputField(
                label: 'Vehicle Number',
                hintText: 'e.g. TS09AB1234',
                initialValue: form.vehicleNo,
                isRequired: true,
                readOnly: isCompleted,
                inputFormatters: [UpperCaseTextFormatter()],
                prefixIcon: const Icon(
                  Icons.local_shipping_outlined,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onChanged: (vehicleNum) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(vehicleNo: vehicleNum);
                },
              ),

              // Driver Name
              // GateInputField(
              //   label: 'Driver Name',
              //   hintText: 'Enter driver name',
              //   controller: _driverNameController,
              //   readOnly: isCompleted,
              //   prefixIcon: const Icon(
              //     Icons.person_outline_rounded,
              //     color: Color(0xFF94A3B8),
              //     size: 20,
              //   ),
              // ),

              // // Driver License
              // GateInputField(
              //   label: 'Driver License',
              //   hintText: 'Enter license number',
              //   controller: _driverLicenseController,
              //   readOnly: isCompleted,
              //   prefixIcon: const Icon(
              //     Icons.badge_outlined,
              //     color: Color(0xFF94A3B8),
              //     size: 20,
              //   ),
              // ),

              // Mobile Number
              // GateInputField(
              //   label: 'Mobile Number',
              //   hintText: 'Enter mobile number',
              //   controller: _mobileNumberController,
              //   readOnly: isCompleted,
              //   keyboardType: TextInputType.phone,
              //   prefixIcon: const Icon(
              //     Icons.phone_outlined,
              //     color: Color(0xFF94A3B8),
              //     size: 20,
              //   ),
              // ),

              // Gate Entry Date
              GateDatePickerField(
                label: 'Gate Entry Date',
                initialValue: form.entryDate,
                readOnly: true,
                isRequired: true,
                onDateSelected: (_) {},
              ),
            ],
          ),

          // CARD 2: MATERIAL
          GateSectionCard(
            number: '2',
            title: 'Material',
            children: [
              // Purchase Order Dropdown
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        'PURCHASE ORDER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Color(0xFF64748B),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        '*',
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<PurchaseOrders, PurchaseOrdersState>(
                    builder: (_, poState) {
                      final items = poState.maybeWhen(
                        orElse: () => <PurchaseOrder>[],
                        success: (data) => data,
                      );

                      return AbsorbPointer(
                        absorbing: isCompleted,
                        child: CustomDropdown<PurchaseOrder>.searchRequest(
                          decoration: CustomDropdownDecoration(
                            closedFillColor: isCompleted
                                ? const Color(0xFFF1F5F9)
                                : const Color(0xFFF8FAFC),
                            expandedFillColor: Colors.white,
                            closedBorder: Border.all(
                              color: const Color(0xFFE2E8F0),
                              width: 1.0,
                            ),
                            expandedBorder: Border.all(
                              color: const Color(0xFF0284C7),
                              width: 1.2,
                            ),
                            closedBorderRadius: BorderRadius.circular(10),
                            expandedBorderRadius: BorderRadius.circular(10),
                            hintStyle: const TextStyle(
                              color: Color(0xFF94A3B8),
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                            headerStyle: const TextStyle(
                              color: Color(0xFF0F172A),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            closedShadow: const [],
                          ),
                          futureRequest: (query) => _onSearchPO(items, query),
                          hintText: 'Select purchase order',
                          items: items,
                          headerBuilder: (_, item, __) => Text(item.poNumber),
                          listItemBuilder: (_, item, isSelected, __) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.poNumber,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Text(
                                    item.date,
                                    style: const TextStyle(
                                      color: Color(0xFF94A3B8),
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '₹${item.totalAmount}',
                                    style: const TextStyle(
                                      color: Color(0xFF0284C7),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          initialItem: form.poNumber.containsValidValue
                              ? PurchaseOrder(
                                  name: '',
                                  poNumber: form.poNumber!,
                                  date: '',
                                  totalAmount: 0.0,
                                )
                              : null,
                          onChanged: (order) {
                            if (order == null) return;
                            context
                                .cubit<ItemNameCubit>()
                                .request(order.poNumber);
                            context.cubit<NewGateEntryCubit>().onValueChanged(
                                  poNumber: order.poNumber,
                                );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                ],
              ),

              // Item Dropdown
              // BlocBuilder<ItemNameCubit, ItemNameCubitState>(
              //   builder: (_, itemState) {
              //     final items = itemState.maybeWhen(
              //       orElse: () => <ItemName>[],
              //       success: (data) => data,
              //     );

              //     if (items.isEmpty) {
              //       return const GateInputField(
              //         label: 'Item',
              //         hintText: 'Select item',
              //         readOnly: true,
              //         prefixIcon: Icon(
              //           Icons.inventory_2_outlined,
              //           color: Color(0xFF94A3B8),
              //           size: 18,
              //         ),
              //       );
              //     }

              //     return Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const Text(
              //           'ITEM',
              //           style: TextStyle(
              //             fontSize: 11,
              //             fontWeight: FontWeight.w700,
              //             letterSpacing: 0.5,
              //             color: Color(0xFF64748B),
              //           ),
              //         ),
              //         const SizedBox(height: 6),
              //         AbsorbPointer(
              //           absorbing: isCompleted,
              //           child: CustomDropdown<ItemName>(
              //             decoration: CustomDropdownDecoration(
              //               closedFillColor: isCompleted
              //                   ? const Color(0xFFF1F5F9)
              //                   : const Color(0xFFF8FAFC),
              //               expandedFillColor: Colors.white,
              //               closedBorder: Border.all(
              //                 color: const Color(0xFFE2E8F0),
              //                 width: 1.0,
              //               ),
              //               expandedBorder: Border.all(
              //                 color: const Color(0xFF0284C7),
              //                 width: 1.2,
              //               ),
              //               closedBorderRadius: BorderRadius.circular(10),
              //               expandedBorderRadius: BorderRadius.circular(10),
              //               hintStyle: const TextStyle(
              //                 color: Color(0xFF94A3B8),
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.normal,
              //               ),
              //               headerStyle: const TextStyle(
              //                 color: Color(0xFF0F172A),
              //                 fontSize: 14,
              //                 fontWeight: FontWeight.w500,
              //               ),
              //               closedShadow: const [],
              //             ),
              //             hintText: 'Select item',
              //             items: items,
              //             headerBuilder: (_, item, __) => Text(item.itemName),
              //             listItemBuilder: (_, item, isSelected, __) =>
              //                 Text(item.itemName,
              //                     style: const TextStyle(fontSize: 14)),
              //             onChanged: (_) {},
              //           ),
              //         ),
              //         const SizedBox(height: 12),
              //       ],
              //     );
              //   },
              // ),

              //  GateInputField(
              //   label: 'Vendor Name',
              //   hintText: 'Enter vendor name',
              //   controller: _vendorNameController,
              //   readOnly: isCompleted,
              //   prefixIcon: const Icon(
              //     Icons.person_outline_rounded,
              //     color: Color(0xFF94A3B8),
              //     size: 20,
              //   ),
              //   onChanged: (value) {
              //      context
              //         .cubit<NewGateEntryCubit>()
              //         .onValueChanged(vendorname: value);

              //   },
              // ),

              // Vendor Invoice Number
              GateInputField(
                label: 'Vendor Invoice No.',
                hintText: 'Enter invoice number',
                isRequired: true,
                initialValue: form.vendorInvNo,
                readOnly: isCompleted,
                prefixIcon: const Icon(
                  Icons.description_outlined,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onChanged: (invNumber) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(vendorInvNo: invNumber);
                },
              ),

              // Invoice Quantity
              GateInputField(
                label: 'Invoice Quantity',
                hintText: 'Enter quantity',
                initialValue: form.invoiceQty,
                readOnly: isCompleted,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(
                  Icons.tag_rounded,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onChanged: (qty) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(invoiceQty: qty);
                },
              ),

              // Vendor Invoice Date
              GateDatePickerField(
                label: 'Vendor Invoice Date',
                hintText: 'Select invoice date',
                isRequired: true,
                readOnly: isCompleted,
                initialValue: form.invoiceDate,
                firstDate: DFU.now().subtract(const Duration(days: 60)),
                lastDate: DFU.now(),
                onDateSelected: (date) {
                  final formattedDate = DFU.friendlyFormat(date);
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(invoiceDate: formattedDate);
                },
              ),

              // Invoice Amount (optional)
              GateInputField(
                label: 'Invoice Amount',
                hintText: 'Enter invoice amount',
                initialValue: form.invoiceAmt,
                readOnly: isCompleted,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                prefixIcon: const Icon(
                  Icons.currency_rupee_rounded,
                  color: Color(0xFF94A3B8),
                  size: 18,
                ),
                onChanged: (amount) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(invoiceAmt: amount);
                },
              ),
            ],
          ),

          // CARD 3: PHOTOS & REMARKS
          GateSectionCard(
            number: '3',
            title: 'Photos & remarks',
            children: [
              // Vehicle Front Photo
              GatePhotoPickerBox(
                title: 'Capture vehicle front photo',
                readOnly: isCompleted,
                imageValue: form.vehiclePhoto,
                onView: () {
                  final data = Pair(
                    form.name ?? 'Vehicle Front Photo',
                    form.vehiclePhoto,
                  );
                  AppRoute.newGateEntryPreview.push(context, extra: data);
                },
                onImage: (file) {
                  if (file == null) {
                    context.cubit<NewGateEntryCubit>().clearVehiclePhoto();
                  } else {
                    context
                        .cubit<NewGateEntryCubit>()
                        .onValueChanged(vehiclePhoto: file);
                  }
                },
              ),

              // Vehicle Back Photo
              GatePhotoPickerBox(
                title: 'Capture vehicle back photo',
                readOnly: isCompleted,
                imageValue: form.vehicleBackPhoto,
                onView: () {
                  final data = Pair(
                    form.name ?? 'Vehicle Back Photo',
                    form.vehicleBackPhoto,
                  );
                  AppRoute.newGateEntryPreview.push(context, extra: data);
                },
                onImage: (file) {
                  if (file == null) {
                    context.cubit<NewGateEntryCubit>().clearVehicleBackPhoto();
                  } else {
                    context
                        .cubit<NewGateEntryCubit>()
                        .onValueChanged(vehicleBackPhoto: file);
                  }
                },
              ),

              // Vendor Invoice Photo
              GatePhotoPickerBox(
                title: 'Capture vendor invoice',
                readOnly: isCompleted,
                imageValue: form.vendorInvPhoto,
                onView: () {
                  final data = Pair(
                    form.name ?? 'Vendor Invoice Photo',
                    form.vendorInvPhoto,
                  );
                  AppRoute.newGateEntryPreview.push(context, extra: data);
                },
                onImage: (file) {
                  if (file == null) {
                    context.cubit<NewGateEntryCubit>().clearInvPhoto();
                  } else {
                    context
                        .cubit<NewGateEntryCubit>()
                        .onValueChanged(invoicePhoto: file);
                  }
                },
              ),

              // Remarks
              GateInputField(
                label: 'Remarks',
                hintText: 'Add remarks (optional)',
                initialValue: form.remarks,
                readOnly: isCompleted,
                minLines: 3,
                maxLines: 4,
                prefixIcon: const Icon(
                  Icons.notes_rounded,
                  color: Color(0xFF94A3B8),
                  size: 20,
                ),
                onChanged: (remarks) {
                  context
                      .cubit<NewGateEntryCubit>()
                      .onValueChanged(remarks: remarks);
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Future<List<PurchaseOrder>> _onSearchPO(
    List<PurchaseOrder> data,
    String query,
  ) async {
    final lower = query.toLowerCase();
    return data
        .where((e) =>
            e.poNumber.toLowerCase().contains(lower) ||
            e.name.toLowerCase().contains(lower))
        .toList();
  }
}
