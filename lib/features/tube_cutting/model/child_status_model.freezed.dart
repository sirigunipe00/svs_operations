// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'child_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChildStatusModel _$ChildStatusModelFromJson(Map<String, dynamic> json) {
  return _ChildStatusModel.fromJson(json);
}

/// @nodoc
mixin _$ChildStatusModel {
  @JsonKey(name: 'name', defaultValue: '')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_status', defaultValue: '')
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_machine_id', defaultValue: '')
  String? get machineId => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_tray_id', defaultValue: '')
  String? get trayId => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
  String? get startImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
  String? get endImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
  double? get startReading => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
  String? get cutQuantity => throw _privateConstructorUsedError;
  @JsonKey(name: 'from_time', defaultValue: '')
  String? get fromTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'to_time', defaultValue: '')
  String? get toTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'completed_qty', defaultValue: 0.0)
  double? get completedQty => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_output_tray', defaultValue: '')
  String? get outputTray => throw _privateConstructorUsedError;

  /// Serializes this ChildStatusModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChildStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChildStatusModelCopyWith<ChildStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChildStatusModelCopyWith<$Res> {
  factory $ChildStatusModelCopyWith(
          ChildStatusModel value, $Res Function(ChildStatusModel) then) =
      _$ChildStatusModelCopyWithImpl<$Res, ChildStatusModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String? name,
      @JsonKey(name: 'custom_status', defaultValue: '') String? status,
      @JsonKey(name: 'custom_machine_id', defaultValue: '') String? machineId,
      @JsonKey(name: 'custom_tray_id', defaultValue: '') String? trayId,
      @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
      String? startImage,
      @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
      String? endImage,
      @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
      double? startReading,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
      String? cutQuantity,
      @JsonKey(name: 'from_time', defaultValue: '') String? fromTime,
      @JsonKey(name: 'to_time', defaultValue: '') String? toTime,
      @JsonKey(name: 'completed_qty', defaultValue: 0.0) double? completedQty,
      @JsonKey(name: 'custom_output_tray', defaultValue: '')
      String? outputTray});
}

/// @nodoc
class _$ChildStatusModelCopyWithImpl<$Res, $Val extends ChildStatusModel>
    implements $ChildStatusModelCopyWith<$Res> {
  _$ChildStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChildStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? status = freezed,
    Object? machineId = freezed,
    Object? trayId = freezed,
    Object? startImage = freezed,
    Object? endImage = freezed,
    Object? startReading = freezed,
    Object? cutQuantity = freezed,
    Object? fromTime = freezed,
    Object? toTime = freezed,
    Object? completedQty = freezed,
    Object? outputTray = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      machineId: freezed == machineId
          ? _value.machineId
          : machineId // ignore: cast_nullable_to_non_nullable
              as String?,
      trayId: freezed == trayId
          ? _value.trayId
          : trayId // ignore: cast_nullable_to_non_nullable
              as String?,
      startImage: freezed == startImage
          ? _value.startImage
          : startImage // ignore: cast_nullable_to_non_nullable
              as String?,
      endImage: freezed == endImage
          ? _value.endImage
          : endImage // ignore: cast_nullable_to_non_nullable
              as String?,
      startReading: freezed == startReading
          ? _value.startReading
          : startReading // ignore: cast_nullable_to_non_nullable
              as double?,
      cutQuantity: freezed == cutQuantity
          ? _value.cutQuantity
          : cutQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      fromTime: freezed == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as String?,
      toTime: freezed == toTime
          ? _value.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as String?,
      completedQty: freezed == completedQty
          ? _value.completedQty
          : completedQty // ignore: cast_nullable_to_non_nullable
              as double?,
      outputTray: freezed == outputTray
          ? _value.outputTray
          : outputTray // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChildStatusModelImplCopyWith<$Res>
    implements $ChildStatusModelCopyWith<$Res> {
  factory _$$ChildStatusModelImplCopyWith(_$ChildStatusModelImpl value,
          $Res Function(_$ChildStatusModelImpl) then) =
      __$$ChildStatusModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String? name,
      @JsonKey(name: 'custom_status', defaultValue: '') String? status,
      @JsonKey(name: 'custom_machine_id', defaultValue: '') String? machineId,
      @JsonKey(name: 'custom_tray_id', defaultValue: '') String? trayId,
      @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
      String? startImage,
      @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
      String? endImage,
      @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
      double? startReading,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
      String? cutQuantity,
      @JsonKey(name: 'from_time', defaultValue: '') String? fromTime,
      @JsonKey(name: 'to_time', defaultValue: '') String? toTime,
      @JsonKey(name: 'completed_qty', defaultValue: 0.0) double? completedQty,
      @JsonKey(name: 'custom_output_tray', defaultValue: '')
      String? outputTray});
}

/// @nodoc
class __$$ChildStatusModelImplCopyWithImpl<$Res>
    extends _$ChildStatusModelCopyWithImpl<$Res, _$ChildStatusModelImpl>
    implements _$$ChildStatusModelImplCopyWith<$Res> {
  __$$ChildStatusModelImplCopyWithImpl(_$ChildStatusModelImpl _value,
      $Res Function(_$ChildStatusModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ChildStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? status = freezed,
    Object? machineId = freezed,
    Object? trayId = freezed,
    Object? startImage = freezed,
    Object? endImage = freezed,
    Object? startReading = freezed,
    Object? cutQuantity = freezed,
    Object? fromTime = freezed,
    Object? toTime = freezed,
    Object? completedQty = freezed,
    Object? outputTray = freezed,
  }) {
    return _then(_$ChildStatusModelImpl(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      machineId: freezed == machineId
          ? _value.machineId
          : machineId // ignore: cast_nullable_to_non_nullable
              as String?,
      trayId: freezed == trayId
          ? _value.trayId
          : trayId // ignore: cast_nullable_to_non_nullable
              as String?,
      startImage: freezed == startImage
          ? _value.startImage
          : startImage // ignore: cast_nullable_to_non_nullable
              as String?,
      endImage: freezed == endImage
          ? _value.endImage
          : endImage // ignore: cast_nullable_to_non_nullable
              as String?,
      startReading: freezed == startReading
          ? _value.startReading
          : startReading // ignore: cast_nullable_to_non_nullable
              as double?,
      cutQuantity: freezed == cutQuantity
          ? _value.cutQuantity
          : cutQuantity // ignore: cast_nullable_to_non_nullable
              as String?,
      fromTime: freezed == fromTime
          ? _value.fromTime
          : fromTime // ignore: cast_nullable_to_non_nullable
              as String?,
      toTime: freezed == toTime
          ? _value.toTime
          : toTime // ignore: cast_nullable_to_non_nullable
              as String?,
      completedQty: freezed == completedQty
          ? _value.completedQty
          : completedQty // ignore: cast_nullable_to_non_nullable
              as double?,
      outputTray: freezed == outputTray
          ? _value.outputTray
          : outputTray // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChildStatusModelImpl extends _ChildStatusModel {
  const _$ChildStatusModelImpl(
      {@JsonKey(name: 'name', defaultValue: '') this.name,
      @JsonKey(name: 'custom_status', defaultValue: '') this.status,
      @JsonKey(name: 'custom_machine_id', defaultValue: '') this.machineId,
      @JsonKey(name: 'custom_tray_id', defaultValue: '') this.trayId,
      @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
      this.startImage,
      @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
      this.endImage,
      @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
      this.startReading,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: '') this.cutQuantity,
      @JsonKey(name: 'from_time', defaultValue: '') this.fromTime,
      @JsonKey(name: 'to_time', defaultValue: '') this.toTime,
      @JsonKey(name: 'completed_qty', defaultValue: 0.0) this.completedQty,
      @JsonKey(name: 'custom_output_tray', defaultValue: '') this.outputTray})
      : super._();

  factory _$ChildStatusModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChildStatusModelImplFromJson(json);

  @override
  @JsonKey(name: 'name', defaultValue: '')
  final String? name;
  @override
  @JsonKey(name: 'custom_status', defaultValue: '')
  final String? status;
  @override
  @JsonKey(name: 'custom_machine_id', defaultValue: '')
  final String? machineId;
  @override
  @JsonKey(name: 'custom_tray_id', defaultValue: '')
  final String? trayId;
  @override
  @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
  final String? startImage;
  @override
  @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
  final String? endImage;
  @override
  @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
  final double? startReading;
  @override
  @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
  final String? cutQuantity;
  @override
  @JsonKey(name: 'from_time', defaultValue: '')
  final String? fromTime;
  @override
  @JsonKey(name: 'to_time', defaultValue: '')
  final String? toTime;
  @override
  @JsonKey(name: 'completed_qty', defaultValue: 0.0)
  final double? completedQty;
  @override
  @JsonKey(name: 'custom_output_tray', defaultValue: '')
  final String? outputTray;

  @override
  String toString() {
    return 'ChildStatusModel(name: $name, status: $status, machineId: $machineId, trayId: $trayId, startImage: $startImage, endImage: $endImage, startReading: $startReading, cutQuantity: $cutQuantity, fromTime: $fromTime, toTime: $toTime, completedQty: $completedQty, outputTray: $outputTray)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChildStatusModelImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.machineId, machineId) ||
                other.machineId == machineId) &&
            (identical(other.trayId, trayId) || other.trayId == trayId) &&
            (identical(other.startImage, startImage) ||
                other.startImage == startImage) &&
            (identical(other.endImage, endImage) ||
                other.endImage == endImage) &&
            (identical(other.startReading, startReading) ||
                other.startReading == startReading) &&
            (identical(other.cutQuantity, cutQuantity) ||
                other.cutQuantity == cutQuantity) &&
            (identical(other.fromTime, fromTime) ||
                other.fromTime == fromTime) &&
            (identical(other.toTime, toTime) || other.toTime == toTime) &&
            (identical(other.completedQty, completedQty) ||
                other.completedQty == completedQty) &&
            (identical(other.outputTray, outputTray) ||
                other.outputTray == outputTray));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      status,
      machineId,
      trayId,
      startImage,
      endImage,
      startReading,
      cutQuantity,
      fromTime,
      toTime,
      completedQty,
      outputTray);

  /// Create a copy of ChildStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChildStatusModelImplCopyWith<_$ChildStatusModelImpl> get copyWith =>
      __$$ChildStatusModelImplCopyWithImpl<_$ChildStatusModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChildStatusModelImplToJson(
      this,
    );
  }
}

abstract class _ChildStatusModel extends ChildStatusModel {
  const factory _ChildStatusModel(
      {@JsonKey(name: 'name', defaultValue: '') final String? name,
      @JsonKey(name: 'custom_status', defaultValue: '') final String? status,
      @JsonKey(name: 'custom_machine_id', defaultValue: '')
      final String? machineId,
      @JsonKey(name: 'custom_tray_id', defaultValue: '') final String? trayId,
      @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
      final String? startImage,
      @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
      final String? endImage,
      @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
      final double? startReading,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
      final String? cutQuantity,
      @JsonKey(name: 'from_time', defaultValue: '') final String? fromTime,
      @JsonKey(name: 'to_time', defaultValue: '') final String? toTime,
      @JsonKey(name: 'completed_qty', defaultValue: 0.0)
      final double? completedQty,
      @JsonKey(name: 'custom_output_tray', defaultValue: '')
      final String? outputTray}) = _$ChildStatusModelImpl;
  const _ChildStatusModel._() : super._();

  factory _ChildStatusModel.fromJson(Map<String, dynamic> json) =
      _$ChildStatusModelImpl.fromJson;

  @override
  @JsonKey(name: 'name', defaultValue: '')
  String? get name;
  @override
  @JsonKey(name: 'custom_status', defaultValue: '')
  String? get status;
  @override
  @JsonKey(name: 'custom_machine_id', defaultValue: '')
  String? get machineId;
  @override
  @JsonKey(name: 'custom_tray_id', defaultValue: '')
  String? get trayId;
  @override
  @JsonKey(name: 'custom_counter_start_image', defaultValue: '')
  String? get startImage;
  @override
  @JsonKey(name: 'custom_counter_end_image', defaultValue: '')
  String? get endImage;
  @override
  @JsonKey(name: 'custom_counter_start_reading', defaultValue: 0.0)
  double? get startReading;
  @override
  @JsonKey(name: 'custom_cut_quantity', defaultValue: '')
  String? get cutQuantity;
  @override
  @JsonKey(name: 'from_time', defaultValue: '')
  String? get fromTime;
  @override
  @JsonKey(name: 'to_time', defaultValue: '')
  String? get toTime;
  @override
  @JsonKey(name: 'completed_qty', defaultValue: 0.0)
  double? get completedQty;
  @override
  @JsonKey(name: 'custom_output_tray', defaultValue: '')
  String? get outputTray;

  /// Create a copy of ChildStatusModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChildStatusModelImplCopyWith<_$ChildStatusModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
