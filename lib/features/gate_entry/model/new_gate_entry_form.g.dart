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
      receiveMode: json['receive_mode'] as String?,
      driverName: json['driver_name_person_name'] as String?,
      driverMobileNo: json['driver_mobile_no_person_mobile_no'] as String?,
      deliveryChallan: json['delivery_challan'] as String?,
      lrNo: json['lr_no'] as String?,
    );

Map<String, dynamic> _$$NewGateEntryFormImplToJson(
    _$NewGateEntryFormImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['po_number'] = instance.poNumber;
  val['vehicle_no'] = instance.vehicleNo;
  val['vendor_name'] = instance.vendorName;
  val['vendor_invoice_no'] = instance.vendorInvNo;
  val['invoice_date'] = instance.invoiceDate;
  val['invoice_qty'] = instance.invoiceQty;
  val['invoice_amount'] = instance.invoiceAmt;
  val['entry_date'] = instance.entryDate;
  val['vehicle_photo'] = instance.vehiclePhoto;
  val['vehicle_back_photo'] = instance.vehicleBackPhoto;
  val['invoice_photo'] = instance.vendorInvPhoto;
  val['remarks'] = instance.remarks;
  val['custom_is_job_work'] = instance.isJobWork;
  val['receive_mode'] = instance.receiveMode;
  val['driver_name_person_name'] = instance.driverName;
  val['driver_mobile_no_person_mobile_no'] = instance.driverMobileNo;
  val['delivery_challan'] = instance.deliveryChallan;
  val['lr_no'] = instance.lrNo;
  return val;
}
