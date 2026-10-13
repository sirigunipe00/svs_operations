// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'work_order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WorkOrderItem _$WorkOrderItemFromJson(Map<String, dynamic> json) {
  return _WorkOrderItem.fromJson(json);
}

/// @nodoc
mixin _$WorkOrderItem {
  @JsonKey(name: 'name', defaultValue: '')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'status', defaultValue: '')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'work_order', defaultValue: '')
  String get workOrder => throw _privateConstructorUsedError;
  @JsonKey(name: 'production_item', defaultValue: '')
  String get productionItem => throw _privateConstructorUsedError;
  @JsonKey(name: 'for_quantity', defaultValue: 0.0)
  double? get forQnty => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
  double get totalComplQnty => throw _privateConstructorUsedError;

  /// Serializes this WorkOrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkOrderItemCopyWith<WorkOrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkOrderItemCopyWith<$Res> {
  factory $WorkOrderItemCopyWith(
          WorkOrderItem value, $Res Function(WorkOrderItem) then) =
      _$WorkOrderItemCopyWithImpl<$Res, WorkOrderItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String name,
      @JsonKey(name: 'status', defaultValue: '') String status,
      @JsonKey(name: 'work_order', defaultValue: '') String workOrder,
      @JsonKey(name: 'production_item', defaultValue: '') String productionItem,
      @JsonKey(name: 'for_quantity', defaultValue: 0.0) double? forQnty,
      @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
      double totalComplQnty});
}

/// @nodoc
class _$WorkOrderItemCopyWithImpl<$Res, $Val extends WorkOrderItem>
    implements $WorkOrderItemCopyWith<$Res> {
  _$WorkOrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? workOrder = null,
    Object? productionItem = null,
    Object? forQnty = freezed,
    Object? totalComplQnty = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workOrder: null == workOrder
          ? _value.workOrder
          : workOrder // ignore: cast_nullable_to_non_nullable
              as String,
      productionItem: null == productionItem
          ? _value.productionItem
          : productionItem // ignore: cast_nullable_to_non_nullable
              as String,
      forQnty: freezed == forQnty
          ? _value.forQnty
          : forQnty // ignore: cast_nullable_to_non_nullable
              as double?,
      totalComplQnty: null == totalComplQnty
          ? _value.totalComplQnty
          : totalComplQnty // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WorkOrderItemImplCopyWith<$Res>
    implements $WorkOrderItemCopyWith<$Res> {
  factory _$$WorkOrderItemImplCopyWith(
          _$WorkOrderItemImpl value, $Res Function(_$WorkOrderItemImpl) then) =
      __$$WorkOrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name', defaultValue: '') String name,
      @JsonKey(name: 'status', defaultValue: '') String status,
      @JsonKey(name: 'work_order', defaultValue: '') String workOrder,
      @JsonKey(name: 'production_item', defaultValue: '') String productionItem,
      @JsonKey(name: 'for_quantity', defaultValue: 0.0) double? forQnty,
      @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
      double totalComplQnty});
}

/// @nodoc
class __$$WorkOrderItemImplCopyWithImpl<$Res>
    extends _$WorkOrderItemCopyWithImpl<$Res, _$WorkOrderItemImpl>
    implements _$$WorkOrderItemImplCopyWith<$Res> {
  __$$WorkOrderItemImplCopyWithImpl(
      _$WorkOrderItemImpl _value, $Res Function(_$WorkOrderItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of WorkOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? status = null,
    Object? workOrder = null,
    Object? productionItem = null,
    Object? forQnty = freezed,
    Object? totalComplQnty = null,
  }) {
    return _then(_$WorkOrderItemImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      workOrder: null == workOrder
          ? _value.workOrder
          : workOrder // ignore: cast_nullable_to_non_nullable
              as String,
      productionItem: null == productionItem
          ? _value.productionItem
          : productionItem // ignore: cast_nullable_to_non_nullable
              as String,
      forQnty: freezed == forQnty
          ? _value.forQnty
          : forQnty // ignore: cast_nullable_to_non_nullable
              as double?,
      totalComplQnty: null == totalComplQnty
          ? _value.totalComplQnty
          : totalComplQnty // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkOrderItemImpl extends _WorkOrderItem {
  const _$WorkOrderItemImpl(
      {@JsonKey(name: 'name', defaultValue: '') required this.name,
      @JsonKey(name: 'status', defaultValue: '') required this.status,
      @JsonKey(name: 'work_order', defaultValue: '') required this.workOrder,
      @JsonKey(name: 'production_item', defaultValue: '')
      required this.productionItem,
      @JsonKey(name: 'for_quantity', defaultValue: 0.0) this.forQnty,
      @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
      required this.totalComplQnty})
      : super._();

  factory _$WorkOrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkOrderItemImplFromJson(json);

  @override
  @JsonKey(name: 'name', defaultValue: '')
  final String name;
  @override
  @JsonKey(name: 'status', defaultValue: '')
  final String status;
  @override
  @JsonKey(name: 'work_order', defaultValue: '')
  final String workOrder;
  @override
  @JsonKey(name: 'production_item', defaultValue: '')
  final String productionItem;
  @override
  @JsonKey(name: 'for_quantity', defaultValue: 0.0)
  final double? forQnty;
  @override
  @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
  final double totalComplQnty;

  @override
  String toString() {
    return 'WorkOrderItem(name: $name, status: $status, workOrder: $workOrder, productionItem: $productionItem, forQnty: $forQnty, totalComplQnty: $totalComplQnty)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkOrderItemImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.workOrder, workOrder) ||
                other.workOrder == workOrder) &&
            (identical(other.productionItem, productionItem) ||
                other.productionItem == productionItem) &&
            (identical(other.forQnty, forQnty) || other.forQnty == forQnty) &&
            (identical(other.totalComplQnty, totalComplQnty) ||
                other.totalComplQnty == totalComplQnty));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, status, workOrder,
      productionItem, forQnty, totalComplQnty);

  /// Create a copy of WorkOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkOrderItemImplCopyWith<_$WorkOrderItemImpl> get copyWith =>
      __$$WorkOrderItemImplCopyWithImpl<_$WorkOrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkOrderItemImplToJson(
      this,
    );
  }
}

abstract class _WorkOrderItem extends WorkOrderItem {
  const factory _WorkOrderItem(
      {@JsonKey(name: 'name', defaultValue: '') required final String name,
      @JsonKey(name: 'status', defaultValue: '') required final String status,
      @JsonKey(name: 'work_order', defaultValue: '')
      required final String workOrder,
      @JsonKey(name: 'production_item', defaultValue: '')
      required final String productionItem,
      @JsonKey(name: 'for_quantity', defaultValue: 0.0) final double? forQnty,
      @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
      required final double totalComplQnty}) = _$WorkOrderItemImpl;
  const _WorkOrderItem._() : super._();

  factory _WorkOrderItem.fromJson(Map<String, dynamic> json) =
      _$WorkOrderItemImpl.fromJson;

  @override
  @JsonKey(name: 'name', defaultValue: '')
  String get name;
  @override
  @JsonKey(name: 'status', defaultValue: '')
  String get status;
  @override
  @JsonKey(name: 'work_order', defaultValue: '')
  String get workOrder;
  @override
  @JsonKey(name: 'production_item', defaultValue: '')
  String get productionItem;
  @override
  @JsonKey(name: 'for_quantity', defaultValue: 0.0)
  double? get forQnty;
  @override
  @JsonKey(name: 'total_completed_qty', defaultValue: 0.0)
  double get totalComplQnty;

  /// Create a copy of WorkOrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkOrderItemImplCopyWith<_$WorkOrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
