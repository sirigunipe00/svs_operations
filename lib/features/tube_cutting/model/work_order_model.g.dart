// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkOrderItemImpl _$$WorkOrderItemImplFromJson(Map<String, dynamic> json) =>
    _$WorkOrderItemImpl(
      name: json['name'] as String? ?? '',
      status: json['status'] as String? ?? '',
      workOrder: json['work_order'] as String? ?? '',
      productionItem: json['production_item'] as String? ?? '',
      forQnty: (json['for_quantity'] as num?)?.toDouble() ?? 0.0,
      totalComplQnty: (json['total_completed_qty'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$WorkOrderItemImplToJson(_$WorkOrderItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'work_order': instance.workOrder,
      'production_item': instance.productionItem,
      'for_quantity': instance.forQnty,
      'total_completed_qty': instance.totalComplQnty,
    };
