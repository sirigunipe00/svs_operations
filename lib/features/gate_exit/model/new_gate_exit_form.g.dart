// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_gate_exit_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewGateExitFormImpl _$$NewGateExitFormImplFromJson(
        Map<String, dynamic> json) =>
    _$NewGateExitFormImpl(
      status: json['status'] as String?,
      name: json['name'] as String?,
      salesInvNumber: json['si_number'] as String?,
      vehicleNo: json['vehicle_no'] as String?,
      vehiclePhoto: json['photo'] as String?,
      vehicleBackPhoto: json['vehicle_back_photo'] as String?,
      exitDate: json['exit_date'] as String,
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$$NewGateExitFormImplToJson(
    _$NewGateExitFormImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  val['si_number'] = instance.salesInvNumber;
  val['vehicle_no'] = instance.vehicleNo;
  val['photo'] = instance.vehiclePhoto;
  val['vehicle_back_photo'] = instance.vehicleBackPhoto;
  val['exit_date'] = instance.exitDate;
  val['remarks'] = instance.remarks;
  return val;
}
