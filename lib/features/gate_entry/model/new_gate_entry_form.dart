import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_gate_entry_form.freezed.dart';
part 'new_gate_entry_form.g.dart';

@freezed
class NewGateEntryForm with _$NewGateEntryForm {
  const factory NewGateEntryForm({
    @JsonKey(includeToJson: false) String? status,
    @JsonKey(includeToJson: true, includeIfNull: false) String? name,
    @JsonKey(name: 'po_number') String? poNumber,
    @JsonKey(name: 'vehicle_no') String? vehicleNo,
    @JsonKey(name: 'vendor_invoice_no') String? vendorInvNo,
    @JsonKey(name: 'invoice_date') String? invoiceDate,
    @JsonKey(name: 'invoice_qty') String? invoiceQty,
    @JsonKey(name: 'invoice_amount') String? invoiceAmt,
    @JsonKey(name: 'entry_date') required String entryDate,
    @JsonKey(name: 'vehicle_photo') String? vehiclePhoto,
    @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
    @JsonKey(name: 'invoice_photo') String? vendorInvPhoto,
    @JsonKey(name: 'remarks') String? remarks,
    @JsonKey(name: 'custom_is_job_work') int? isJobWork,
  }) = _NewGateEntryForm;

  factory NewGateEntryForm.fromJson(Map<String, Object?> json)
      => _$NewGateEntryFormFromJson(json);
}