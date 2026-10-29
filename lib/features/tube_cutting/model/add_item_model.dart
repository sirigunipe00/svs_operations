import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_item_model.freezed.dart';
part 'add_item_model.g.dart';

@freezed
class AddItemModel with _$AddItemModel {
  const AddItemModel._();
  const factory AddItemModel({
    @JsonKey(name: 'job_card', defaultValue: '') String? jobCard,
    @JsonKey(name: 'work_order', defaultValue: '') String? workOrder,
    @JsonKey(name: 'operation', defaultValue: '') String? operation,
    @JsonKey(name: 'employee', defaultValue: '') String? employee,
    @JsonKey(name: 'machine', defaultValue: '') String? machine,
    @JsonKey(name: 'input_tray', defaultValue: '') String? inputTray,
    @JsonKey(name: 'counter_start_readings', defaultValue: 0)
    int? startReadings,
    @JsonKey(name: 'counter_start_image', defaultValue: '') String? startImage,
    @JsonKey(name: 'child_id', defaultValue: '') String? childId,
    @JsonKey(name: 'output_tray', defaultValue: '') String? outputTray,
    @JsonKey(name: 'counter_end_readings', defaultValue: 0) int? endReadings,
    @JsonKey(name: 'counter_end_image', defaultValue: '') String? endImage,
    @JsonKey(name: 'custom_cut_quantity', defaultValue: 0) int? cutQnty,
    @JsonKey(name: 'rejection_tray', defaultValue: '') String? rejectionTray,
    @JsonKey(name: 'rejection_tray_image', defaultValue: '')
    String? rejectionTrayImage,
    @JsonKey(name: 'rejection_counter', defaultValue: 0)
    int? rejectionCounter,
    @JsonKey(name: 'custom_scrap_kgs')
    double? scrapKgs,
  }) = _AddItemModel;

  factory AddItemModel.fromJson(Map<String, dynamic> json) =>
      _$AddItemModelFromJson(json);
}
