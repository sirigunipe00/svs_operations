// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operation_scan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OperationScanModel _$OperationScanModelFromJson(Map<String, dynamic> json) {
  return _OperationScanModel.fromJson(json);
}

/// @nodoc
mixin _$OperationScanModel {
  @JsonKey(name: 'name', defaultValue: '')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
  int? get correctiveOperation => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
  int? get ismachineScan => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
  int? get isCounterScan => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
  int? get isQntyEntry => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
  int? get isRejection => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_rework_required', defaultValue: 0)
  int? get isRework => throw _privateConstructorUsedError;

  /// Serializes this OperationScanModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OperationScanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OperationScanModelCopyWith<OperationScanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationScanModelCopyWith<$Res> {
  factory $OperationScanModelCopyWith(
          OperationScanModel value, $Res Function(OperationScanModel) then) =
      _$OperationScanModelCopyWithImpl<$Res, OperationScanModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String name,
      @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
      int? correctiveOperation,
      @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
      int? ismachineScan,
      @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
      int? isCounterScan,
      @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
      int? isQntyEntry,
      @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
      int? isRejection,
      @JsonKey(name: 'custom_rework_required', defaultValue: 0) int? isRework});
}

/// @nodoc
class _$OperationScanModelCopyWithImpl<$Res, $Val extends OperationScanModel>
    implements $OperationScanModelCopyWith<$Res> {
  _$OperationScanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OperationScanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? correctiveOperation = freezed,
    Object? ismachineScan = freezed,
    Object? isCounterScan = freezed,
    Object? isQntyEntry = freezed,
    Object? isRejection = freezed,
    Object? isRework = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      correctiveOperation: freezed == correctiveOperation
          ? _value.correctiveOperation
          : correctiveOperation // ignore: cast_nullable_to_non_nullable
              as int?,
      ismachineScan: freezed == ismachineScan
          ? _value.ismachineScan
          : ismachineScan // ignore: cast_nullable_to_non_nullable
              as int?,
      isCounterScan: freezed == isCounterScan
          ? _value.isCounterScan
          : isCounterScan // ignore: cast_nullable_to_non_nullable
              as int?,
      isQntyEntry: freezed == isQntyEntry
          ? _value.isQntyEntry
          : isQntyEntry // ignore: cast_nullable_to_non_nullable
              as int?,
      isRejection: freezed == isRejection
          ? _value.isRejection
          : isRejection // ignore: cast_nullable_to_non_nullable
              as int?,
      isRework: freezed == isRework
          ? _value.isRework
          : isRework // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OperationScanModelImplCopyWith<$Res>
    implements $OperationScanModelCopyWith<$Res> {
  factory _$$OperationScanModelImplCopyWith(_$OperationScanModelImpl value,
          $Res Function(_$OperationScanModelImpl) then) =
      __$$OperationScanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String name,
      @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
      int? correctiveOperation,
      @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
      int? ismachineScan,
      @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
      int? isCounterScan,
      @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
      int? isQntyEntry,
      @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
      int? isRejection,
      @JsonKey(name: 'custom_rework_required', defaultValue: 0) int? isRework});
}

/// @nodoc
class __$$OperationScanModelImplCopyWithImpl<$Res>
    extends _$OperationScanModelCopyWithImpl<$Res, _$OperationScanModelImpl>
    implements _$$OperationScanModelImplCopyWith<$Res> {
  __$$OperationScanModelImplCopyWithImpl(_$OperationScanModelImpl _value,
      $Res Function(_$OperationScanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OperationScanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? correctiveOperation = freezed,
    Object? ismachineScan = freezed,
    Object? isCounterScan = freezed,
    Object? isQntyEntry = freezed,
    Object? isRejection = freezed,
    Object? isRework = freezed,
  }) {
    return _then(_$OperationScanModelImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      correctiveOperation: freezed == correctiveOperation
          ? _value.correctiveOperation
          : correctiveOperation // ignore: cast_nullable_to_non_nullable
              as int?,
      ismachineScan: freezed == ismachineScan
          ? _value.ismachineScan
          : ismachineScan // ignore: cast_nullable_to_non_nullable
              as int?,
      isCounterScan: freezed == isCounterScan
          ? _value.isCounterScan
          : isCounterScan // ignore: cast_nullable_to_non_nullable
              as int?,
      isQntyEntry: freezed == isQntyEntry
          ? _value.isQntyEntry
          : isQntyEntry // ignore: cast_nullable_to_non_nullable
              as int?,
      isRejection: freezed == isRejection
          ? _value.isRejection
          : isRejection // ignore: cast_nullable_to_non_nullable
              as int?,
      isRework: freezed == isRework
          ? _value.isRework
          : isRework // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OperationScanModelImpl extends _OperationScanModel {
  const _$OperationScanModelImpl(
      {@JsonKey(name: 'name', defaultValue: '') required this.name,
      @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
      this.correctiveOperation,
      @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
      this.ismachineScan,
      @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
      this.isCounterScan,
      @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
      this.isQntyEntry,
      @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
      this.isRejection,
      @JsonKey(name: 'custom_rework_required', defaultValue: 0) this.isRework})
      : super._();

  factory _$OperationScanModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperationScanModelImplFromJson(json);

  @override
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @override
  @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
  final int? correctiveOperation;
  @override
  @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
  final int? ismachineScan;
  @override
  @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
  final int? isCounterScan;
  @override
  @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
  final int? isQntyEntry;
  @override
  @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
  final int? isRejection;
  @override
  @JsonKey(name: 'custom_rework_required', defaultValue: 0)
  final int? isRework;

  @override
  String toString() {
    return 'OperationScanModel(name: $name, correctiveOperation: $correctiveOperation, ismachineScan: $ismachineScan, isCounterScan: $isCounterScan, isQntyEntry: $isQntyEntry, isRejection: $isRejection, isRework: $isRework)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationScanModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.correctiveOperation, correctiveOperation) ||
                other.correctiveOperation == correctiveOperation) &&
            (identical(other.ismachineScan, ismachineScan) ||
                other.ismachineScan == ismachineScan) &&
            (identical(other.isCounterScan, isCounterScan) ||
                other.isCounterScan == isCounterScan) &&
            (identical(other.isQntyEntry, isQntyEntry) ||
                other.isQntyEntry == isQntyEntry) &&
            (identical(other.isRejection, isRejection) ||
                other.isRejection == isRejection) &&
            (identical(other.isRework, isRework) ||
                other.isRework == isRework));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, correctiveOperation,
      ismachineScan, isCounterScan, isQntyEntry, isRejection, isRework);

  /// Create a copy of OperationScanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationScanModelImplCopyWith<_$OperationScanModelImpl> get copyWith =>
      __$$OperationScanModelImplCopyWithImpl<_$OperationScanModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OperationScanModelImplToJson(
      this,
    );
  }
}

abstract class _OperationScanModel extends OperationScanModel {
  const factory _OperationScanModel(
      {@JsonKey(name: 'name', defaultValue: '') required final String name,
      @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
      final int? correctiveOperation,
      @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
      final int? ismachineScan,
      @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
      final int? isCounterScan,
      @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
      final int? isQntyEntry,
      @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
      final int? isRejection,
      @JsonKey(name: 'custom_rework_required', defaultValue: 0)
      final int? isRework}) = _$OperationScanModelImpl;
  const _OperationScanModel._() : super._();

  factory _OperationScanModel.fromJson(Map<String, dynamic> json) =
      _$OperationScanModelImpl.fromJson;

  @override
  @JsonKey(name: 'name', defaultValue: '')
  String get name;
  @override
  @JsonKey(name: 'is_corrective_operation', defaultValue: 0)
  int? get correctiveOperation;
  @override
  @JsonKey(name: 'custom_machine_scan_required', defaultValue: 0)
  int? get ismachineScan;
  @override
  @JsonKey(name: 'custom_counter_scan_required', defaultValue: 0)
  int? get isCounterScan;
  @override
  @JsonKey(name: 'custom_final_quantity_entry_required', defaultValue: 0)
  int? get isQntyEntry;
  @override
  @JsonKey(name: 'custom_rejection_required', defaultValue: 0)
  int? get isRejection;
  @override
  @JsonKey(name: 'custom_rework_required', defaultValue: 0)
  int? get isRework;

  /// Create a copy of OperationScanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationScanModelImplCopyWith<_$OperationScanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
