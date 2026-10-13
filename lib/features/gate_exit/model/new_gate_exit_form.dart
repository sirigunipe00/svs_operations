import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_gate_exit_form.freezed.dart';
part 'new_gate_exit_form.g.dart';

@freezed
class NewGateExitForm with _$NewGateExitForm {
  const factory NewGateExitForm({
    @JsonKey(includeToJson: false) String? status,
    @JsonKey(includeToJson: true, includeIfNull: false) String? name,
    @JsonKey(name: 'si_number') String? salesInvNumber,
    @JsonKey(name: 'vehicle_no') String? vehicleNo,
    @JsonKey(name: 'photo') String? vehiclePhoto,
    @JsonKey(name: 'vehicle_back_photo') String? vehicleBackPhoto,
    @JsonKey(name: 'exit_date') required String exitDate,
    @JsonKey(name: 'remarks') String? remarks,
  }) = _NewGateExitForm;

  factory NewGateExitForm.fromJson(Map<String, Object?> json)
      => _$NewGateExitFormFromJson(json);
} 