// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UpdateItemModelImpl _$$UpdateItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UpdateItemModelImpl(
      jobCard: json['job_card'] as String? ?? '',
      workOrder: json['work_order'] as String? ?? '',
      operation: json['operation'] as String? ?? '',
      employee: json['employee'] as String? ?? '',
      childId: json['child_id'] as String? ?? '',
      outputTray: json['output_tray'] as String? ?? '',
      readings: (json['counter_end_readings'] as num?)?.toInt() ?? 0,
      endImage: json['counter_end_image'] as String? ?? '',
    );

Map<String, dynamic> _$$UpdateItemModelImplToJson(
        _$UpdateItemModelImpl instance) =>
    <String, dynamic>{
      'job_card': instance.jobCard,
      'work_order': instance.workOrder,
      'operation': instance.operation,
      'employee': instance.employee,
      'child_id': instance.childId,
      'output_tray': instance.outputTray,
      'counter_end_readings': instance.readings,
      'counter_end_image': instance.endImage,
    };
