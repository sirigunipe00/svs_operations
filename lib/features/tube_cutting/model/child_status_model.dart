



import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_status_model.freezed.dart';
part 'child_status_model.g.dart';

@freezed
class ChildStatusModel with _$ChildStatusModel {
  const ChildStatusModel._();
  const factory ChildStatusModel({
    @JsonKey(name: 'name', defaultValue: '') String? name,
    @JsonKey(name: 'custom_status', defaultValue: '') String? status,
    @JsonKey(name: 'custom_counter_start_image', defaultValue: '') String? startImage,
    @JsonKey(name: 'custom_counter_end_image', defaultValue: '') String? endImage,
    @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0) double? startReading,
  }) = _ChildStatusModel;

  factory ChildStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ChildStatusModelFromJson(json);
}
