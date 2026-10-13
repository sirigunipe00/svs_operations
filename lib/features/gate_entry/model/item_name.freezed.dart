// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_name.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemName _$ItemNameFromJson(Map<String, dynamic> json) {
  return _ItemName.fromJson(json);
}

/// @nodoc
mixin _$ItemName {
  @JsonKey(name: 'item_name')
  String get itemName => throw _privateConstructorUsedError;

  /// Serializes this ItemName to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemNameCopyWith<ItemName> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemNameCopyWith<$Res> {
  factory $ItemNameCopyWith(ItemName value, $Res Function(ItemName) then) =
      _$ItemNameCopyWithImpl<$Res, ItemName>;
  @useResult
  $Res call({@JsonKey(name: 'item_name') String itemName});
}

/// @nodoc
class _$ItemNameCopyWithImpl<$Res, $Val extends ItemName>
    implements $ItemNameCopyWith<$Res> {
  _$ItemNameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
  }) {
    return _then(_value.copyWith(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemNameImplCopyWith<$Res>
    implements $ItemNameCopyWith<$Res> {
  factory _$$ItemNameImplCopyWith(
          _$ItemNameImpl value, $Res Function(_$ItemNameImpl) then) =
      __$$ItemNameImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'item_name') String itemName});
}

/// @nodoc
class __$$ItemNameImplCopyWithImpl<$Res>
    extends _$ItemNameCopyWithImpl<$Res, _$ItemNameImpl>
    implements _$$ItemNameImplCopyWith<$Res> {
  __$$ItemNameImplCopyWithImpl(
      _$ItemNameImpl _value, $Res Function(_$ItemNameImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemName
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemName = null,
  }) {
    return _then(_$ItemNameImpl(
      itemName: null == itemName
          ? _value.itemName
          : itemName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemNameImpl implements _ItemName {
  const _$ItemNameImpl({@JsonKey(name: 'item_name') required this.itemName});

  factory _$ItemNameImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemNameImplFromJson(json);

  @override
  @JsonKey(name: 'item_name')
  final String itemName;

  @override
  String toString() {
    return 'ItemName(itemName: $itemName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemNameImpl &&
            (identical(other.itemName, itemName) ||
                other.itemName == itemName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, itemName);

  /// Create a copy of ItemName
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemNameImplCopyWith<_$ItemNameImpl> get copyWith =>
      __$$ItemNameImplCopyWithImpl<_$ItemNameImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemNameImplToJson(
      this,
    );
  }
}

abstract class _ItemName implements ItemName {
  const factory _ItemName(
          {@JsonKey(name: 'item_name') required final String itemName}) =
      _$ItemNameImpl;

  factory _ItemName.fromJson(Map<String, dynamic> json) =
      _$ItemNameImpl.fromJson;

  @override
  @JsonKey(name: 'item_name')
  String get itemName;

  /// Create a copy of ItemName
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemNameImplCopyWith<_$ItemNameImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
