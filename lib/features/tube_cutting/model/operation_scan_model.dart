
import 'package:freezed_annotation/freezed_annotation.dart';

part 'operation_scan_model.freezed.dart';
part 'operation_scan_model.g.dart';

@freezed
class OperationScanModel with _$OperationScanModel {
  const OperationScanModel._();
  const factory OperationScanModel({
    @JsonKey(name: 'name', defaultValue: '') required String name,
    @JsonKey(name: 'is_corrective_operation', defaultValue: 0) int? correctiveOperation,
    @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0) int? ismachineScan,
    @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0) int? isCounterScan,
    @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0) int? isQntyEntry,
    @JsonKey(name: 'custom_rejection_required', defaultValue: 0) int? isRejection,
    @JsonKey(name: 'custom_rework_required', defaultValue: 0) int? isRework,
  }) = _OperationScanModel;

  factory OperationScanModel.fromJson(Map<String, dynamic> json) =>
      _$OperationScanModelFromJson(json);
}