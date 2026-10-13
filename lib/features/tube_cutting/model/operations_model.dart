import 'package:freezed_annotation/freezed_annotation.dart';

part 'operations_model.freezed.dart';
part 'operations_model.g.dart';

@freezed
class OperationsModel with _$OperationsModel {
  const factory OperationsModel({
    @JsonKey(name: 'data', defaultValue: {})
    required Map<String, List<String>> data,
  }) = _OperationsModel;

  factory OperationsModel.fromJson(Map<String, dynamic> json) =>
      _$OperationsModelFromJson(json);
}