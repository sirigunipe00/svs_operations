// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChildStatusModelImpl _$$ChildStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChildStatusModelImpl(
      name: json['name'] as String? ?? '',
      status: (json['custom_status'] ?? json['status']) as String? ?? '',
      machineId: (json['custom_machine_id'] ?? json['machine_id'] ?? json['machine']) as String? ?? '',
      trayId: (json['custom_tray_id'] ?? json['input_tray'] ?? json['tray_id']) as String? ?? '',
      startImage: (json['custom_counter_start_image'] ?? json['counter_start_image']) as String? ?? '',
      endImage: (json['custom_counter_end_image'] ?? json['counter_end_image']) as String? ?? '',
      startReading:
          ((json['custom_counter_start_reading'] ?? json['counter_start_reading']) as num?)?.toDouble() ?? 0.0,
      cutQuantity: (json['custom_cut_quantity'] ?? json['cut_quantity'])?.toString() ?? '',
      fromTime: json['from_time'] as String? ?? '',
      toTime: json['to_time'] as String? ?? '',
      completedQty: (json['completed_qty'] as num?)?.toDouble() ?? 0.0,
      outputTray: (json['custom_output_tray'] ?? json['output_tray']) as String? ?? '',
    );

Map<String, dynamic> _$$ChildStatusModelImplToJson(
        _$ChildStatusModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'custom_status': instance.status,
      'custom_machine_id': instance.machineId,
      'custom_tray_id': instance.trayId,
      'custom_counter_start_image': instance.startImage,
      'custom_counter_end_image': instance.endImage,
      'custom_counter_start_reading': instance.startReading,
      'custom_cut_quantity': instance.cutQuantity,
      'from_time': instance.fromTime,
      'to_time': instance.toTime,
      'completed_qty': instance.completedQty,
      'custom_output_tray': instance.outputTray,
    };
