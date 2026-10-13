// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_scan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperationScanModelImpl _$$OperationScanModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OperationScanModelImpl(
      name: json['name'] as String? ?? '',
      correctiveOperation:
          (json['is_corrective_operation'] as num?)?.toInt() ?? 0,
      ismachineScan:
          (json['custom_machine_scan_required'] as num?)?.toInt() ?? 0,
      isCounterScan:
          (json['custom_counter_scan_required'] as num?)?.toInt() ?? 0,
      isQntyEntry:
          (json['custom_final_quantity_entry_required'] as num?)?.toInt() ?? 0,
      isRejection: (json['custom_rejection_required'] as num?)?.toInt() ?? 0,
      isRework: (json['custom_rework_required'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$OperationScanModelImplToJson(
        _$OperationScanModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'is_corrective_operation': instance.correctiveOperation,
      'custom_machine_scan_required': instance.ismachineScan,
      'custom_counter_scan_required': instance.isCounterScan,
      'custom_final_quantity_entry_required': instance.isQntyEntry,
      'custom_rejection_required': instance.isRejection,
      'custom_rework_required': instance.isRework,
    };
