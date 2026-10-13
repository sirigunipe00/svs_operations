// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gate_exit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GateExitImpl _$$GateExitImplFromJson(Map<String, dynamic> json) =>
    _$GateExitImpl(
      name: json['name'] as String,
      salesInvNo: json['si_number'] as String? ?? '',
      vehicleNo: json['vehicle_no'] as String? ?? '',
      exitDate: json['gate_exit_date'] as String? ?? '',
      vehiclePhoto: json['vehicle_photo'] as String?,
      vehicleBackPhoto: json['vehicle_back_photo'] as String?,
      remarks: json['remarks'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$$GateExitImplToJson(_$GateExitImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'si_number': instance.salesInvNo,
      'vehicle_no': instance.vehicleNo,
      'gate_exit_date': instance.exitDate,
      'vehicle_photo': instance.vehiclePhoto,
      'vehicle_back_photo': instance.vehicleBackPhoto,
      'remarks': instance.remarks,
      'status': instance.status,
    };
