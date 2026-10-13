import 'package:freezed_annotation/freezed_annotation.dart';

part 'gate_exit.freezed.dart';
part 'gate_exit.g.dart';

@freezed
abstract class GateExit with _$GateExit {
  const factory GateExit({
    required String name,
    @JsonKey(name: 'si_number', defaultValue: '') required String salesInvNo,
    @JsonKey(name: 'vehicle_no', defaultValue: '') required String vehicleNo,
    @JsonKey(name: 'gate_exit_date', defaultValue: '') required String exitDate,
    @JsonKey(name: 'vehicle_photo') String? vehiclePhoto,
    @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
    String? remarks,
    String? status,
  }) = _GateExit;

  factory GateExit.fromJson(Map<String, Object?> json) =>
      _$GateExitFromJson(json);
}
