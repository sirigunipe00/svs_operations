import 'package:freezed_annotation/freezed_annotation.dart';

part 'gate_entry.freezed.dart';
part 'gate_entry.g.dart';

@freezed
class GateEntry with _$GateEntry {
  const factory GateEntry({
    required String name,
    String? status,
    @JsonKey(name: 'po_number') required String poNumber,
    @JsonKey(name: 'vehicle_no', defaultValue: '') required String vehicleNo,
    @JsonKey(name: 'vendor_invoice_no', defaultValue: '') required String vendorInvNo,
    @JsonKey(name: 'invoice_date', defaultValue: '') required String invoiceDate,
    @JsonKey(name: 'vendor_invoice_quantity') double? invoiceQty,
    @JsonKey(name: 'invoice_amount') double? invoiceAmt,
    @JsonKey(name: 'gate_entry_date', defaultValue: '') required String entryDate,
    @JsonKey(name: 'vehicle_image') String? vehiclePhoto,
    @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
    @JsonKey(name: 'vendor_invoice_photo') String? invoicePhoto,
    @JsonKey(name: 'remarks') String? remarks,
    @JsonKey(name: 'is_job_work') int? isJobWork,
  }) = _GateEntry;

  factory GateEntry.fromJson(Map<String, Object?> json)
      => _$GateEntryFromJson(json);
}