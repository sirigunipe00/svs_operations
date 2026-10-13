// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddItemModelImpl _$$AddItemModelImplFromJson(Map<String, dynamic> json) =>
    _$AddItemModelImpl(
      jobCard: json['job_card'] as String? ?? '',
      workOrder: json['work_order'] as String? ?? '',
      operation: json['operation'] as String? ?? '',
      employee: json['employee'] as String? ?? '',
      machine: json['machine'] as String? ?? '',
      inputTray: json['input_tray'] as String? ?? '',
      startReadings: (json['counter_start_readings'] as num?)?.toInt() ?? 0,
      startImage: json['counter_start_image'] as String? ?? '',
      childId: json['child_id'] as String? ?? '',
      outputTray: json['output_tray'] as String? ?? '',
      endReadings: (json['counter_end_readings'] as num?)?.toInt() ?? 0,
      endImage: json['counter_end_image'] as String? ?? '',
      cutQnty: (json['custom_cut_quantity'] as num?)?.toInt() ?? 0,
      rejectionTray: json['rejection_tray'] as String? ?? '',
      rejectionTrayImage: json['rejection_tray_image'] as String? ?? '',
      rejectionCounter: (json['rejection_counter'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AddItemModelImplToJson(_$AddItemModelImpl instance) =>
    <String, dynamic>{
      'job_card': instance.jobCard,
      'work_order': instance.workOrder,
      'operation': instance.operation,
      'employee': instance.employee,
      'machine': instance.machine,
      'input_tray': instance.inputTray,
      'counter_start_readings': instance.startReadings,
      'counter_start_image': instance.startImage,
      'child_id': instance.childId,
      'output_tray': instance.outputTray,
      'counter_end_readings': instance.endReadings,
      'counter_end_image': instance.endImage,
      'custom_cut_quantity': instance.cutQnty,
      'rejection_tray': instance.rejectionTray,
      'rejection_tray_image': instance.rejectionTrayImage,
      'rejection_counter': instance.rejectionCounter,
    };
