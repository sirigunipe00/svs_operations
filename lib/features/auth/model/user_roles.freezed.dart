// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_roles.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserRoles _$UserRolesFromJson(Map<String, dynamic> json) {
  return _UserRoles.fromJson(json);
}

/// @nodoc
mixin _$UserRoles {
  @JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
  int get sfgOperations => throw _privateConstructorUsedError;
  @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
  int get fgOperations => throw _privateConstructorUsedError;
  @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)
  int get exit => throw _privateConstructorUsedError;
  @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
  int get entry => throw _privateConstructorUsedError;
  @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
  int get operations => throw _privateConstructorUsedError;

  /// Serializes this UserRoles to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserRoles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserRolesCopyWith<UserRoles> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserRolesCopyWith<$Res> {
  factory $UserRolesCopyWith(UserRoles value, $Res Function(UserRoles) then) =
      _$UserRolesCopyWithImpl<$Res, UserRoles>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
      int sfgOperations,
      @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
      int fgOperations,
      @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0) int exit,
      @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
      int entry,
      @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
      int operations});
}

/// @nodoc
class _$UserRolesCopyWithImpl<$Res, $Val extends UserRoles>
    implements $UserRolesCopyWith<$Res> {
  _$UserRolesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserRoles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sfgOperations = null,
    Object? fgOperations = null,
    Object? exit = null,
    Object? entry = null,
    Object? operations = null,
  }) {
    return _then(_value.copyWith(
      sfgOperations: null == sfgOperations
          ? _value.sfgOperations
          : sfgOperations // ignore: cast_nullable_to_non_nullable
              as int,
      fgOperations: null == fgOperations
          ? _value.fgOperations
          : fgOperations // ignore: cast_nullable_to_non_nullable
              as int,
      exit: null == exit
          ? _value.exit
          : exit // ignore: cast_nullable_to_non_nullable
              as int,
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as int,
      operations: null == operations
          ? _value.operations
          : operations // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserRolesImplCopyWith<$Res>
    implements $UserRolesCopyWith<$Res> {
  factory _$$UserRolesImplCopyWith(
          _$UserRolesImpl value, $Res Function(_$UserRolesImpl) then) =
      __$$UserRolesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
      int sfgOperations,
      @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
      int fgOperations,
      @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0) int exit,
      @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
      int entry,
      @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
      int operations});
}

/// @nodoc
class __$$UserRolesImplCopyWithImpl<$Res>
    extends _$UserRolesCopyWithImpl<$Res, _$UserRolesImpl>
    implements _$$UserRolesImplCopyWith<$Res> {
  __$$UserRolesImplCopyWithImpl(
      _$UserRolesImpl _value, $Res Function(_$UserRolesImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserRoles
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? sfgOperations = null,
    Object? fgOperations = null,
    Object? exit = null,
    Object? entry = null,
    Object? operations = null,
  }) {
    return _then(_$UserRolesImpl(
      sfgOperations: null == sfgOperations
          ? _value.sfgOperations
          : sfgOperations // ignore: cast_nullable_to_non_nullable
              as int,
      fgOperations: null == fgOperations
          ? _value.fgOperations
          : fgOperations // ignore: cast_nullable_to_non_nullable
              as int,
      exit: null == exit
          ? _value.exit
          : exit // ignore: cast_nullable_to_non_nullable
              as int,
      entry: null == entry
          ? _value.entry
          : entry // ignore: cast_nullable_to_non_nullable
              as int,
      operations: null == operations
          ? _value.operations
          : operations // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserRolesImpl extends _UserRoles {
  const _$UserRolesImpl(
      {@JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
      required this.sfgOperations,
      @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
      required this.fgOperations,
      @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)
      required this.exit,
      @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
      required this.entry,
      @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
      required this.operations})
      : super._();

  factory _$UserRolesImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserRolesImplFromJson(json);

  @override
  @JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
  final int sfgOperations;
  @override
  @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
  final int fgOperations;
  @override
  @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)
  final int exit;
  @override
  @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
  final int entry;
  @override
  @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
  final int operations;

  @override
  String toString() {
    return 'UserRoles(sfgOperations: $sfgOperations, fgOperations: $fgOperations, exit: $exit, entry: $entry, operations: $operations)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserRolesImpl &&
            (identical(other.sfgOperations, sfgOperations) ||
                other.sfgOperations == sfgOperations) &&
            (identical(other.fgOperations, fgOperations) ||
                other.fgOperations == fgOperations) &&
            (identical(other.exit, exit) || other.exit == exit) &&
            (identical(other.entry, entry) || other.entry == entry) &&
            (identical(other.operations, operations) ||
                other.operations == operations));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, sfgOperations, fgOperations, exit, entry, operations);

  /// Create a copy of UserRoles
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserRolesImplCopyWith<_$UserRolesImpl> get copyWith =>
      __$$UserRolesImplCopyWithImpl<_$UserRolesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserRolesImplToJson(
      this,
    );
  }
}

abstract class _UserRoles extends UserRoles {
  const factory _UserRoles(
      {@JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
      required final int sfgOperations,
      @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
      required final int fgOperations,
      @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)
      required final int exit,
      @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
      required final int entry,
      @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
      required final int operations}) = _$UserRolesImpl;
  const _UserRoles._() : super._();

  factory _UserRoles.fromJson(Map<String, dynamic> json) =
      _$UserRolesImpl.fromJson;

  @override
  @JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0)
  int get sfgOperations;
  @override
  @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0)
  int get fgOperations;
  @override
  @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)
  int get exit;
  @override
  @JsonKey(name: 'Show Gate Entry in Mobile App', defaultValue: 0)
  int get entry;
  @override
  @JsonKey(name: 'Show Operations in Mobile App', defaultValue: 0)
  int get operations;

  /// Create a copy of UserRoles
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserRolesImplCopyWith<_$UserRolesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
