// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'operations_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OperationsModel _$OperationsModelFromJson(Map<String, dynamic> json) {
  return _OperationsModel.fromJson(json);
}

/// @nodoc
mixin _$OperationsModel {
  @JsonKey(name: 'data', defaultValue: {})
  Map<String, List<String>> get data => throw _privateConstructorUsedError;

  /// Serializes this OperationsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OperationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OperationsModelCopyWith<OperationsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperationsModelCopyWith<$Res> {
  factory $OperationsModelCopyWith(
          OperationsModel value, $Res Function(OperationsModel) then) =
      _$OperationsModelCopyWithImpl<$Res, OperationsModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data', defaultValue: {})
      Map<String, List<String>> data});
}

/// @nodoc
class _$OperationsModelCopyWithImpl<$Res, $Val extends OperationsModel>
    implements $OperationsModelCopyWith<$Res> {
  _$OperationsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OperationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OperationsModelImplCopyWith<$Res>
    implements $OperationsModelCopyWith<$Res> {
  factory _$$OperationsModelImplCopyWith(_$OperationsModelImpl value,
          $Res Function(_$OperationsModelImpl) then) =
      __$$OperationsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data', defaultValue: {})
      Map<String, List<String>> data});
}

/// @nodoc
class __$$OperationsModelImplCopyWithImpl<$Res>
    extends _$OperationsModelCopyWithImpl<$Res, _$OperationsModelImpl>
    implements _$$OperationsModelImplCopyWith<$Res> {
  __$$OperationsModelImplCopyWithImpl(
      _$OperationsModelImpl _value, $Res Function(_$OperationsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OperationsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$OperationsModelImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OperationsModelImpl implements _OperationsModel {
  const _$OperationsModelImpl(
      {@JsonKey(name: 'data', defaultValue: {})
      required final Map<String, List<String>> data})
      : _data = data;

  factory _$OperationsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OperationsModelImplFromJson(json);

  final Map<String, List<String>> _data;
  @override
  @JsonKey(name: 'data', defaultValue: {})
  Map<String, List<String>> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'OperationsModel(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OperationsModelImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  /// Create a copy of OperationsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OperationsModelImplCopyWith<_$OperationsModelImpl> get copyWith =>
      __$$OperationsModelImplCopyWithImpl<_$OperationsModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OperationsModelImplToJson(
      this,
    );
  }
}

abstract class _OperationsModel implements OperationsModel {
  const factory _OperationsModel(
      {@JsonKey(name: 'data', defaultValue: {})
      required final Map<String, List<String>> data}) = _$OperationsModelImpl;

  factory _OperationsModel.fromJson(Map<String, dynamic> json) =
      _$OperationsModelImpl.fromJson;

  @override
  @JsonKey(name: 'data', defaultValue: {})
  Map<String, List<String>> get data;

  /// Create a copy of OperationsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OperationsModelImplCopyWith<_$OperationsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
