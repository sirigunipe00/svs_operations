import 'package:freezed_annotation/freezed_annotation.dart';

part 'child_status_model.freezed.dart';
part 'child_status_model.g.dart';

@freezed
class ChildStatusModel with _$ChildStatusModel {
  const ChildStatusModel._();
  const factory ChildStatusModel({
    @JsonKey(name: 'name', defaultValue: '') String? name,
    @JsonKey(name: 'custom_status', defaultValue: '') String? status,
    @JsonKey(name: 'custom_machine_id', defaultValue: '') String? machineId,
    @JsonKey(name: 'custom_tray_id', defaultValue: '') String? trayId,
    @JsonKey(name: 'custom_counter_start_image', defaultValue: '') String? startImage,
    @JsonKey(name: 'custom_counter_end_image', defaultValue: '') String? endImage,
    @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0) double? startReading,
    @JsonKey(name: 'custom_cut_quantity', defaultValue: '') String? cutQuantity,
  }) = _ChildStatusModel;

  String? get customMachineId => machineId;
  String? get customTrayId => trayId;
  String? get customCounterStartImage => startImage;
  String? get counterStartImage => startImage;
  String? get customCutQuantity => cutQuantity;
  String? get custom_cut_quantity => cutQuantity;
  double? get customCounterStartReading => startReading;
  double? get custom_counter_start_reading => startReading;
  String? get custom_machine_id => machineId;
  String? get custom_tray_id => trayId;
  String? get custom_counter_start_image => startImage;

  factory ChildStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ChildStatusModelFromJson(json);
}
