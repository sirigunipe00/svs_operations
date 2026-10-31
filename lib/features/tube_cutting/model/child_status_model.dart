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
    @JsonKey(name: 'from_time', defaultValue: '') String? fromTime,
    @JsonKey(name: 'to_time', defaultValue: '') String? toTime,
    @JsonKey(name: 'completed_qty', defaultValue: 0.0) double? completedQty,
    @JsonKey(name: 'custom_output_tray', defaultValue: '') String? outputTray,
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
  String? get customOutputTray => outputTray;

  String? get formattedStartTime {
    if (fromTime == null || fromTime!.trim().isEmpty) return null;
    try {
      final trimmed = fromTime!.trim();
      if (trimmed.contains(' ') || trimmed.contains('T')) {
        final dt = DateTime.tryParse(trimmed.replaceAll(' ', 'T'));
        if (dt != null) {
          final hour = dt.hour.toString().padLeft(2, '0');
          final minute = dt.minute.toString().padLeft(2, '0');
          return '$hour:$minute';
        }
      }
      final parts = trimmed.split(':');
      if (parts.length >= 2) {
        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
      }
    } catch (_) {}
    return fromTime;
  }

  String? get formattedEndTime {
    if (toTime == null || toTime!.trim().isEmpty) return null;
    try {
      final trimmed = toTime!.trim();
      if (trimmed.contains(' ') || trimmed.contains('T')) {
        final dt = DateTime.tryParse(trimmed.replaceAll(' ', 'T'));
        if (dt != null) {
          final hour = dt.hour.toString().padLeft(2, '0');
          final minute = dt.minute.toString().padLeft(2, '0');
          return '$hour:$minute';
        }
      }
      final parts = trimmed.split(':');
      if (parts.length >= 2) {
        return '${parts[0].padLeft(2, '0')}:${parts[1].padLeft(2, '0')}';
      }
    } catch (_) {}
    return toTime;
  }

  String? get formattedTimeRange {
    final start = formattedStartTime;
    final end = formattedEndTime;
    if (start != null && end != null) {
      return '$start to $end';
    } else if (start != null) {
      return 'Started $start';
    } else if (end != null) {
      return 'Completed $end';
    }
    return null;
  }

  factory ChildStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ChildStatusModelFromJson(json);
}
