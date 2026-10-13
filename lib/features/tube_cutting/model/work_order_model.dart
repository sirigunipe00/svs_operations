



import 'package:freezed_annotation/freezed_annotation.dart';

part 'work_order_model.freezed.dart';
part 'work_order_model.g.dart';

@freezed
class WorkOrderItem with _$WorkOrderItem {
  const WorkOrderItem._();
  const factory WorkOrderItem({
    @JsonKey(name: 'name', defaultValue: '') required String name,
    @JsonKey(name: 'status', defaultValue: '') required String status,
    @JsonKey(name: 'work_order', defaultValue: '') required String workOrder,
    @JsonKey(name: 'production_item', defaultValue: '') required String productionItem,
    @JsonKey(name: 'for_quantity', defaultValue: 0.0) double? forQnty,
    @JsonKey(name: 'total_completed_qty', defaultValue: 0.0) required double totalComplQnty,
  }) = _WorkOrderItem;

  factory WorkOrderItem.fromJson(Map<String, dynamic> json) =>
      _$WorkOrderItemFromJson(json);
}
