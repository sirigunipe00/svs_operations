// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddItemModel _$AddItemModelFromJson(Map<String, dynamic> json) {
  return _AddItemModel.fromJson(json);
}

/// @nodoc
mixin _$AddItemModel {
  @JsonKey(name: 'job_card', defaultValue: '')
  String? get jobCard => throw _privateConstructorUsedError;
  @JsonKey(name: 'work_order', defaultValue: '')
  String? get workOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'operation', defaultValue: '')
  String? get operation => throw _privateConstructorUsedError;
  @JsonKey(name: 'employee', defaultValue: '')
  String? get employee => throw _privateConstructorUsedError;
  @JsonKey(name: 'machine', defaultValue: '')
  String? get machine => throw _privateConstructorUsedError;
  @JsonKey(name: 'input_tray', defaultValue: '')
  String? get inputTray => throw _privateConstructorUsedError;
  @JsonKey(name: 'counter_start_readings', defaultValue: 0)
  int? get startReadings => throw _privateConstructorUsedError;
  @JsonKey(name: 'counter_start_image', defaultValue: '')
  String? get startImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'child_id', defaultValue: '')
  String? get childId => throw _privateConstructorUsedError;
  @JsonKey(name: 'output_tray', defaultValue: '')
  String? get outputTray => throw _privateConstructorUsedError;
  @JsonKey(name: 'counter_end_readings', defaultValue: 0)
  int? get endReadings => throw _privateConstructorUsedError;
  @JsonKey(name: 'counter_end_image', defaultValue: '')
  String? get endImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_cut_quantity', defaultValue: 0)
  int? get cutQnty => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_tray', defaultValue: '')
  String? get rejectionTray => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_tray_image', defaultValue: '')
  String? get rejectionTrayImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'rejection_counter', defaultValue: 0)
  int? get rejectionCounter => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_scrap_kgs')
  double? get scrapKgs => throw _privateConstructorUsedError;

  /// Serializes this AddItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddItemModelCopyWith<AddItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddItemModelCopyWith<$Res> {
  factory $AddItemModelCopyWith(
          AddItemModel value, $Res Function(AddItemModel) then) =
      _$AddItemModelCopyWithImpl<$Res, AddItemModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'job_card', defaultValue: '') String? jobCard,
      @JsonKey(name: 'work_order', defaultValue: '') String? workOrder,
      @JsonKey(name: 'operation', defaultValue: '') String? operation,
      @JsonKey(name: 'employee', defaultValue: '') String? employee,
      @JsonKey(name: 'machine', defaultValue: '') String? machine,
      @JsonKey(name: 'input_tray', defaultValue: '') String? inputTray,
      @JsonKey(name: 'counter_start_readings', defaultValue: 0)
      int? startReadings,
      @JsonKey(name: 'counter_start_image', defaultValue: '')
      String? startImage,
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
      double? scrapKgs});
}

/// @nodoc
class _$AddItemModelCopyWithImpl<$Res, $Val extends AddItemModel>
    implements $AddItemModelCopyWith<$Res> {
  _$AddItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobCard = freezed,
    Object? workOrder = freezed,
    Object? operation = freezed,
    Object? employee = freezed,
    Object? machine = freezed,
    Object? inputTray = freezed,
    Object? startReadings = freezed,
    Object? startImage = freezed,
    Object? childId = freezed,
    Object? outputTray = freezed,
    Object? endReadings = freezed,
    Object? endImage = freezed,
    Object? cutQnty = freezed,
    Object? rejectionTray = freezed,
    Object? rejectionTrayImage = freezed,
    Object? rejectionCounter = freezed,
    Object? scrapKgs = freezed,
  }) {
    return _then(_value.copyWith(
      jobCard: freezed == jobCard
          ? _value.jobCard
          : jobCard // ignore: cast_nullable_to_non_nullable
              as String?,
      workOrder: freezed == workOrder
          ? _value.workOrder
          : workOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as String?,
      machine: freezed == machine
          ? _value.machine
          : machine // ignore: cast_nullable_to_non_nullable
              as String?,
      inputTray: freezed == inputTray
          ? _value.inputTray
          : inputTray // ignore: cast_nullable_to_non_nullable
              as String?,
      startReadings: freezed == startReadings
          ? _value.startReadings
          : startReadings // ignore: cast_nullable_to_non_nullable
              as int?,
      startImage: freezed == startImage
          ? _value.startImage
          : startImage // ignore: cast_nullable_to_non_nullable
              as String?,
      childId: freezed == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String?,
      outputTray: freezed == outputTray
          ? _value.outputTray
          : outputTray // ignore: cast_nullable_to_non_nullable
              as String?,
      endReadings: freezed == endReadings
          ? _value.endReadings
          : endReadings // ignore: cast_nullable_to_non_nullable
              as int?,
      endImage: freezed == endImage
          ? _value.endImage
          : endImage // ignore: cast_nullable_to_non_nullable
              as String?,
      cutQnty: freezed == cutQnty
          ? _value.cutQnty
          : cutQnty // ignore: cast_nullable_to_non_nullable
              as int?,
      rejectionTray: freezed == rejectionTray
          ? _value.rejectionTray
          : rejectionTray // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionTrayImage: freezed == rejectionTrayImage
          ? _value.rejectionTrayImage
          : rejectionTrayImage // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionCounter: freezed == rejectionCounter
          ? _value.rejectionCounter
          : rejectionCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      scrapKgs: freezed == scrapKgs
          ? _value.scrapKgs
          : scrapKgs // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddItemModelImplCopyWith<$Res>
    implements $AddItemModelCopyWith<$Res> {
  factory _$$AddItemModelImplCopyWith(
          _$AddItemModelImpl value, $Res Function(_$AddItemModelImpl) then) =
      __$$AddItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'job_card', defaultValue: '') String? jobCard,
      @JsonKey(name: 'work_order', defaultValue: '') String? workOrder,
      @JsonKey(name: 'operation', defaultValue: '') String? operation,
      @JsonKey(name: 'employee', defaultValue: '') String? employee,
      @JsonKey(name: 'machine', defaultValue: '') String? machine,
      @JsonKey(name: 'input_tray', defaultValue: '') String? inputTray,
      @JsonKey(name: 'counter_start_readings', defaultValue: 0)
      int? startReadings,
      @JsonKey(name: 'counter_start_image', defaultValue: '')
      String? startImage,
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
      double? scrapKgs});
}

/// @nodoc
class __$$AddItemModelImplCopyWithImpl<$Res>
    extends _$AddItemModelCopyWithImpl<$Res, _$AddItemModelImpl>
    implements _$$AddItemModelImplCopyWith<$Res> {
  __$$AddItemModelImplCopyWithImpl(
      _$AddItemModelImpl _value, $Res Function(_$AddItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? jobCard = freezed,
    Object? workOrder = freezed,
    Object? operation = freezed,
    Object? employee = freezed,
    Object? machine = freezed,
    Object? inputTray = freezed,
    Object? startReadings = freezed,
    Object? startImage = freezed,
    Object? childId = freezed,
    Object? outputTray = freezed,
    Object? endReadings = freezed,
    Object? endImage = freezed,
    Object? cutQnty = freezed,
    Object? rejectionTray = freezed,
    Object? rejectionTrayImage = freezed,
    Object? rejectionCounter = freezed,
    Object? scrapKgs = freezed,
  }) {
    return _then(_$AddItemModelImpl(
      jobCard: freezed == jobCard
          ? _value.jobCard
          : jobCard // ignore: cast_nullable_to_non_nullable
              as String?,
      workOrder: freezed == workOrder
          ? _value.workOrder
          : workOrder // ignore: cast_nullable_to_non_nullable
              as String?,
      operation: freezed == operation
          ? _value.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      employee: freezed == employee
          ? _value.employee
          : employee // ignore: cast_nullable_to_non_nullable
              as String?,
      machine: freezed == machine
          ? _value.machine
          : machine // ignore: cast_nullable_to_non_nullable
              as String?,
      inputTray: freezed == inputTray
          ? _value.inputTray
          : inputTray // ignore: cast_nullable_to_non_nullable
              as String?,
      startReadings: freezed == startReadings
          ? _value.startReadings
          : startReadings // ignore: cast_nullable_to_non_nullable
              as int?,
      startImage: freezed == startImage
          ? _value.startImage
          : startImage // ignore: cast_nullable_to_non_nullable
              as String?,
      childId: freezed == childId
          ? _value.childId
          : childId // ignore: cast_nullable_to_non_nullable
              as String?,
      outputTray: freezed == outputTray
          ? _value.outputTray
          : outputTray // ignore: cast_nullable_to_non_nullable
              as String?,
      endReadings: freezed == endReadings
          ? _value.endReadings
          : endReadings // ignore: cast_nullable_to_non_nullable
              as int?,
      endImage: freezed == endImage
          ? _value.endImage
          : endImage // ignore: cast_nullable_to_non_nullable
              as String?,
      cutQnty: freezed == cutQnty
          ? _value.cutQnty
          : cutQnty // ignore: cast_nullable_to_non_nullable
              as int?,
      rejectionTray: freezed == rejectionTray
          ? _value.rejectionTray
          : rejectionTray // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionTrayImage: freezed == rejectionTrayImage
          ? _value.rejectionTrayImage
          : rejectionTrayImage // ignore: cast_nullable_to_non_nullable
              as String?,
      rejectionCounter: freezed == rejectionCounter
          ? _value.rejectionCounter
          : rejectionCounter // ignore: cast_nullable_to_non_nullable
              as int?,
      scrapKgs: freezed == scrapKgs
          ? _value.scrapKgs
          : scrapKgs // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddItemModelImpl extends _AddItemModel {
  const _$AddItemModelImpl(
      {@JsonKey(name: 'job_card', defaultValue: '') this.jobCard,
      @JsonKey(name: 'work_order', defaultValue: '') this.workOrder,
      @JsonKey(name: 'operation', defaultValue: '') this.operation,
      @JsonKey(name: 'employee', defaultValue: '') this.employee,
      @JsonKey(name: 'machine', defaultValue: '') this.machine,
      @JsonKey(name: 'input_tray', defaultValue: '') this.inputTray,
      @JsonKey(name: 'counter_start_readings', defaultValue: 0)
      this.startReadings,
      @JsonKey(name: 'counter_start_image', defaultValue: '') this.startImage,
      @JsonKey(name: 'child_id', defaultValue: '') this.childId,
      @JsonKey(name: 'output_tray', defaultValue: '') this.outputTray,
      @JsonKey(name: 'counter_end_readings', defaultValue: 0) this.endReadings,
      @JsonKey(name: 'counter_end_image', defaultValue: '') this.endImage,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: 0) this.cutQnty,
      @JsonKey(name: 'rejection_tray', defaultValue: '') this.rejectionTray,
      @JsonKey(name: 'rejection_tray_image', defaultValue: '')
      this.rejectionTrayImage,
      @JsonKey(name: 'rejection_counter', defaultValue: 0)
      this.rejectionCounter,
      @JsonKey(name: 'custom_scrap_kgs')
      this.scrapKgs})
      : super._();

  factory _$AddItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddItemModelImplFromJson(json);

  @override
  @JsonKey(name: 'job_card', defaultValue: '')
  final String? jobCard;
  @override
  @JsonKey(name: 'work_order', defaultValue: '')
  final String? workOrder;
  @override
  @JsonKey(name: 'operation', defaultValue: '')
  final String? operation;
  @override
  @JsonKey(name: 'employee', defaultValue: '')
  final String? employee;
  @override
  @JsonKey(name: 'machine', defaultValue: '')
  final String? machine;
  @override
  @JsonKey(name: 'input_tray', defaultValue: '')
  final String? inputTray;
  @override
  @JsonKey(name: 'counter_start_readings', defaultValue: 0)
  final int? startReadings;
  @override
  @JsonKey(name: 'counter_start_image', defaultValue: '')
  final String? startImage;
  @override
  @JsonKey(name: 'child_id', defaultValue: '')
  final String? childId;
  @override
  @JsonKey(name: 'output_tray', defaultValue: '')
  final String? outputTray;
  @override
  @JsonKey(name: 'counter_end_readings', defaultValue: 0)
  final int? endReadings;
  @override
  @JsonKey(name: 'counter_end_image', defaultValue: '')
  final String? endImage;
  @override
  @JsonKey(name: 'custom_cut_quantity', defaultValue: 0)
  final int? cutQnty;
  @override
  @JsonKey(name: 'rejection_tray', defaultValue: '')
  final String? rejectionTray;
  @override
  @JsonKey(name: 'rejection_tray_image', defaultValue: '')
  final String? rejectionTrayImage;
  @override
  @JsonKey(name: 'rejection_counter', defaultValue: 0)
  final int? rejectionCounter;
  @override
  @JsonKey(name: 'custom_scrap_kgs')
  final double? scrapKgs;

  @override
  String toString() {
    return 'AddItemModel(jobCard: $jobCard, workOrder: $workOrder, operation: $operation, employee: $employee, machine: $machine, inputTray: $inputTray, startReadings: $startReadings, startImage: $startImage, childId: $childId, outputTray: $outputTray, endReadings: $endReadings, endImage: $endImage, cutQnty: $cutQnty, rejectionTray: $rejectionTray, rejectionTrayImage: $rejectionTrayImage, rejectionCounter: $rejectionCounter, scrapKgs: $scrapKgs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddItemModelImpl &&
            (identical(other.jobCard, jobCard) || other.jobCard == jobCard) &&
            (identical(other.workOrder, workOrder) ||
                other.workOrder == workOrder) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.employee, employee) ||
                other.employee == employee) &&
            (identical(other.machine, machine) || other.machine == machine) &&
            (identical(other.inputTray, inputTray) ||
                other.inputTray == inputTray) &&
            (identical(other.startReadings, startReadings) ||
                other.startReadings == startReadings) &&
            (identical(other.startImage, startImage) ||
                other.startImage == startImage) &&
            (identical(other.childId, childId) || other.childId == childId) &&
            (identical(other.outputTray, outputTray) ||
                other.outputTray == outputTray) &&
            (identical(other.endReadings, endReadings) ||
                other.endReadings == endReadings) &&
            (identical(other.endImage, endImage) ||
                other.endImage == endImage) &&
            (identical(other.cutQnty, cutQnty) || other.cutQnty == cutQnty) &&
            (identical(other.rejectionTray, rejectionTray) ||
                other.rejectionTray == rejectionTray) &&
            (identical(other.rejectionTrayImage, rejectionTrayImage) ||
                other.rejectionTrayImage == rejectionTrayImage) &&
            (identical(other.rejectionCounter, rejectionCounter) ||
                other.rejectionCounter == rejectionCounter) &&
            (identical(other.scrapKgs, scrapKgs) ||
                other.scrapKgs == scrapKgs));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      jobCard,
      workOrder,
      operation,
      employee,
      machine,
      inputTray,
      startReadings,
      startImage,
      childId,
      outputTray,
      endReadings,
      endImage,
      cutQnty,
      rejectionTray,
      rejectionTrayImage,
      rejectionCounter,
      scrapKgs);

  /// Create a copy of AddItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddItemModelImplCopyWith<_$AddItemModelImpl> get copyWith =>
      __$$AddItemModelImplCopyWithImpl<_$AddItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddItemModelImplToJson(
      this,
    );
  }
}

abstract class _AddItemModel extends AddItemModel {
  const factory _AddItemModel(
      {@JsonKey(name: 'job_card', defaultValue: '') final String? jobCard,
      @JsonKey(name: 'work_order', defaultValue: '') final String? workOrder,
      @JsonKey(name: 'operation', defaultValue: '') final String? operation,
      @JsonKey(name: 'employee', defaultValue: '') final String? employee,
      @JsonKey(name: 'machine', defaultValue: '') final String? machine,
      @JsonKey(name: 'input_tray', defaultValue: '') final String? inputTray,
      @JsonKey(name: 'counter_start_readings', defaultValue: 0)
      final int? startReadings,
      @JsonKey(name: 'counter_start_image', defaultValue: '')
      final String? startImage,
      @JsonKey(name: 'child_id', defaultValue: '') final String? childId,
      @JsonKey(name: 'output_tray', defaultValue: '') final String? outputTray,
      @JsonKey(name: 'counter_end_readings', defaultValue: 0)
      final int? endReadings,
      @JsonKey(name: 'counter_end_image', defaultValue: '')
      final String? endImage,
      @JsonKey(name: 'custom_cut_quantity', defaultValue: 0) final int? cutQnty,
      @JsonKey(name: 'rejection_tray', defaultValue: '')
      final String? rejectionTray,
      @JsonKey(name: 'rejection_tray_image', defaultValue: '')
      final String? rejectionTrayImage,
      @JsonKey(name: 'rejection_counter', defaultValue: 0)
      final int? rejectionCounter,
      @JsonKey(name: 'custom_scrap_kgs')
      final double? scrapKgs}) = _$AddItemModelImpl;
  const _AddItemModel._() : super._();

  factory _AddItemModel.fromJson(Map<String, dynamic> json) =
      _$AddItemModelImpl.fromJson;

  @override
  @JsonKey(name: 'job_card', defaultValue: '')
  String? get jobCard;
  @override
  @JsonKey(name: 'work_order', defaultValue: '')
  String? get workOrder;
  @override
  @JsonKey(name: 'operation', defaultValue: '')
  String? get operation;
  @override
  @JsonKey(name: 'employee', defaultValue: '')
  String? get employee;
  @override
  @JsonKey(name: 'machine', defaultValue: '')
  String? get machine;
  @override
  @JsonKey(name: 'input_tray', defaultValue: '')
  String? get inputTray;
  @override
  @JsonKey(name: 'counter_start_readings', defaultValue: 0)
  int? get startReadings;
  @override
  @JsonKey(name: 'counter_start_image', defaultValue: '')
  String? get startImage;
  @override
  @JsonKey(name: 'child_id', defaultValue: '')
  String? get childId;
  @override
  @JsonKey(name: 'output_tray', defaultValue: '')
  String? get outputTray;
  @override
  @JsonKey(name: 'counter_end_readings', defaultValue: 0)
  int? get endReadings;
  @override
  @JsonKey(name: 'counter_end_image', defaultValue: '')
  String? get endImage;
  @override
  @JsonKey(name: 'custom_cut_quantity', defaultValue: 0)
  int? get cutQnty;
  @override
  @JsonKey(name: 'rejection_tray', defaultValue: '')
  String? get rejectionTray;
  @override
  @JsonKey(name: 'rejection_tray_image', defaultValue: '')
  String? get rejectionTrayImage;
  @override
  @JsonKey(name: 'rejection_counter', defaultValue: 0)
  int? get rejectionCounter;
  @override
  @JsonKey(name: 'custom_scrap_kgs')
  double? get scrapKgs;

  /// Create a copy of AddItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddItemModelImplCopyWith<_$AddItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
