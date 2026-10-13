



import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_item_model.freezed.dart';
part 'update_item_model.g.dart';

@freezed
class UpdateItemModel with _$UpdateItemModel {
  const UpdateItemModel._();
  const factory UpdateItemModel({
    @JsonKey(name: 'job_card', defaultValue: '') String? jobCard,
    @JsonKey(name: 'work_order', defaultValue: '') String? workOrder,
    @JsonKey(name: 'operation', defaultValue: '') String? operation,
    @JsonKey(name: 'employee', defaultValue: '') String? employee,
    @JsonKey(name: 'child_id', defaultValue: '') String? childId,
    @JsonKey(name: 'output_tray', defaultValue: '') String? outputTray,
    @JsonKey(name: 'counter_end_readings', defaultValue: 0) int? readings,
    @JsonKey(name: 'counter_end_image', defaultValue: '') String? endImage,
  }) = _UpdateItemModel;

  factory UpdateItemModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateItemModelFromJson(json);
}
