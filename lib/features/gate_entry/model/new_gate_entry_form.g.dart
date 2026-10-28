// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_gate_entry_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewGateEntryFormImpl _$$NewGateEntryFormImplFromJson(
        Map<String, dynamic> json) =>
    _$NewGateEntryFormImpl(
      status: json['status'] as String?,
      name: json['name'] as String?,
      poNumber: json['po_number'] as String?,
      vehicleNo: json['vehicle_no'] as String?,
      vendorName: json['vendor_name'] as String?,
      vendorInvNo: json['vendor_invoice_no'] as String?,
      invoiceDate: json['invoice_date'] as String?,
      invoiceQty: json['invoice_qty'] as String?,
      invoiceAmt: json['invoice_amount'] as String?,
      entryDate: json['entry_date'] as String,
      vehiclePhoto: json['vehicle_photo'] as String?,
      vehicleBackPhoto: json['vehicle_back_photo'] as String?,
      vendorInvPhoto: json['invoice_photo'] as String?,
      remarks: json['remarks'] as String?,
      isJobWork: (json['custom_is_job_work'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NewGateEntryFormImplToJson(
        _$NewGateEntryFormImpl instance) =>
    <String, dynamic>{
      if (instance.name case final value?) 'name': value,
      'po_number': instance.poNumber,
      'vehicle_no': instance.vehicleNo,
      'vendor_name': instance.vendorName,
      'vendor_invoice_no': instance.vendorInvNo,
      'invoice_date': instance.invoiceDate,
      'invoice_qty': instance.invoiceQty,
      'invoice_amount': instance.invoiceAmt,
      'entry_date': instance.entryDate,
      'vehicle_photo': instance.vehiclePhoto,
      'vehicle_back_photo': instance.vehicleBackPhoto,
      'invoice_photo': instance.vendorInvPhoto,
      'remarks': instance.remarks,
      'custom_is_job_work': instance.isJobWork,
    };
