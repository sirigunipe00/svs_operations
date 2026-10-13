// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'child_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChildStatusModelImpl _$$ChildStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ChildStatusModelImpl(
      name: json['name'] as String? ?? '',
      status: json['custom_status'] as String? ?? '',
      startImage: json['custom_counter_start_image'] as String? ?? '',
      endImage: json['custom_counter_end_image'] as String? ?? '',
      startReading:
          (json['custom_counter_start_reading'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$ChildStatusModelImplToJson(
        _$ChildStatusModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'custom_status': instance.status,
      'custom_counter_start_image': instance.startImage,
      'custom_counter_end_image': instance.endImage,
      'custom_counter_start_reading': instance.startReading,
    };
