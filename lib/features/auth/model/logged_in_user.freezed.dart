// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'logged_in_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LoggedInUser _$LoggedInUserFromJson(Map<String, dynamic> json) {
  return _LoggedInUser.fromJson(json);
}

/// @nodoc
mixin _$LoggedInUser {
  String get name => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name', defaultValue: '')
  String get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name', defaultValue: '')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'api_key', defaultValue: '')
  String get apiKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'api_secret', defaultValue: '')
  String get apiSecret => throw _privateConstructorUsedError;
  @JsonKey(name: 'email', defaultValue: '')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: '')
  String get password => throw _privateConstructorUsedError;
  @JsonKey(name: 'role_profile_name', defaultValue: '')
  String? get roleProfileName => throw _privateConstructorUsedError;
  @JsonKey(name: 'gender')
  String? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'birth_date')
  String? get bithDate => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  @JsonKey(name: 'mobile_no')
  String? get mobileNo => throw _privateConstructorUsedError;

  /// Serializes this LoggedInUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LoggedInUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LoggedInUserCopyWith<LoggedInUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoggedInUserCopyWith<$Res> {
  factory $LoggedInUserCopyWith(
          LoggedInUser value, $Res Function(LoggedInUser) then) =
      _$LoggedInUserCopyWithImpl<$Res, LoggedInUser>;
  @useResult
  $Res call(
      {String name,
      String username,
      @JsonKey(name: 'first_name', defaultValue: '') String firstName,
      @JsonKey(name: 'last_name', defaultValue: '') String lastName,
      @JsonKey(name: 'api_key', defaultValue: '') String apiKey,
      @JsonKey(name: 'api_secret', defaultValue: '') String apiSecret,
      @JsonKey(name: 'email', defaultValue: '') String? email,
      @JsonKey(defaultValue: '') String password,
      @JsonKey(name: 'role_profile_name', defaultValue: '')
      String? roleProfileName,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'birth_date') String? bithDate,
      String? phone,
      String? location,
      String? bio,
      @JsonKey(name: 'mobile_no') String? mobileNo});
}

/// @nodoc
class _$LoggedInUserCopyWithImpl<$Res, $Val extends LoggedInUser>
    implements $LoggedInUserCopyWith<$Res> {
  _$LoggedInUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoggedInUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? apiKey = null,
    Object? apiSecret = null,
    Object? email = freezed,
    Object? password = null,
    Object? roleProfileName = freezed,
    Object? gender = freezed,
    Object? bithDate = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? bio = freezed,
    Object? mobileNo = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      apiSecret: null == apiSecret
          ? _value.apiSecret
          : apiSecret // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      roleProfileName: freezed == roleProfileName
          ? _value.roleProfileName
          : roleProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      bithDate: freezed == bithDate
          ? _value.bithDate
          : bithDate // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNo: freezed == mobileNo
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LoggedInUserImplCopyWith<$Res>
    implements $LoggedInUserCopyWith<$Res> {
  factory _$$LoggedInUserImplCopyWith(
          _$LoggedInUserImpl value, $Res Function(_$LoggedInUserImpl) then) =
      __$$LoggedInUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String username,
      @JsonKey(name: 'first_name', defaultValue: '') String firstName,
      @JsonKey(name: 'last_name', defaultValue: '') String lastName,
      @JsonKey(name: 'api_key', defaultValue: '') String apiKey,
      @JsonKey(name: 'api_secret', defaultValue: '') String apiSecret,
      @JsonKey(name: 'email', defaultValue: '') String? email,
      @JsonKey(defaultValue: '') String password,
      @JsonKey(name: 'role_profile_name', defaultValue: '')
      String? roleProfileName,
      @JsonKey(name: 'gender') String? gender,
      @JsonKey(name: 'birth_date') String? bithDate,
      String? phone,
      String? location,
      String? bio,
      @JsonKey(name: 'mobile_no') String? mobileNo});
}

/// @nodoc
class __$$LoggedInUserImplCopyWithImpl<$Res>
    extends _$LoggedInUserCopyWithImpl<$Res, _$LoggedInUserImpl>
    implements _$$LoggedInUserImplCopyWith<$Res> {
  __$$LoggedInUserImplCopyWithImpl(
      _$LoggedInUserImpl _value, $Res Function(_$LoggedInUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of LoggedInUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? username = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? apiKey = null,
    Object? apiSecret = null,
    Object? email = freezed,
    Object? password = null,
    Object? roleProfileName = freezed,
    Object? gender = freezed,
    Object? bithDate = freezed,
    Object? phone = freezed,
    Object? location = freezed,
    Object? bio = freezed,
    Object? mobileNo = freezed,
  }) {
    return _then(_$LoggedInUserImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      apiKey: null == apiKey
          ? _value.apiKey
          : apiKey // ignore: cast_nullable_to_non_nullable
              as String,
      apiSecret: null == apiSecret
          ? _value.apiSecret
          : apiSecret // ignore: cast_nullable_to_non_nullable
              as String,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      roleProfileName: freezed == roleProfileName
          ? _value.roleProfileName
          : roleProfileName // ignore: cast_nullable_to_non_nullable
              as String?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      bithDate: freezed == bithDate
          ? _value.bithDate
          : bithDate // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      mobileNo: freezed == mobileNo
          ? _value.mobileNo
          : mobileNo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LoggedInUserImpl extends _LoggedInUser {
  const _$LoggedInUserImpl(
      {required this.name,
      required this.username,
      @JsonKey(name: 'first_name', defaultValue: '') required this.firstName,
      @JsonKey(name: 'last_name', defaultValue: '') required this.lastName,
      @JsonKey(name: 'api_key', defaultValue: '') required this.apiKey,
      @JsonKey(name: 'api_secret', defaultValue: '') required this.apiSecret,
      @JsonKey(name: 'email', defaultValue: '') this.email,
      @JsonKey(defaultValue: '') required this.password,
      @JsonKey(name: 'role_profile_name', defaultValue: '')
      this.roleProfileName,
      @JsonKey(name: 'gender') this.gender,
      @JsonKey(name: 'birth_date') this.bithDate,
      this.phone,
      this.location,
      this.bio,
      @JsonKey(name: 'mobile_no') this.mobileNo})
      : super._();

  factory _$LoggedInUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$LoggedInUserImplFromJson(json);

  @override
  final String name;
  @override
  final String username;
  @override
  @JsonKey(name: 'first_name', defaultValue: '')
  final String firstName;
  @override
  @JsonKey(name: 'last_name', defaultValue: '')
  final String lastName;
  @override
  @JsonKey(name: 'api_key', defaultValue: '')
  final String apiKey;
  @override
  @JsonKey(name: 'api_secret', defaultValue: '')
  final String apiSecret;
  @override
  @JsonKey(name: 'email', defaultValue: '')
  final String? email;
  @override
  @JsonKey(defaultValue: '')
  final String password;
  @override
  @JsonKey(name: 'role_profile_name', defaultValue: '')
  final String? roleProfileName;
  @override
  @JsonKey(name: 'gender')
  final String? gender;
  @override
  @JsonKey(name: 'birth_date')
  final String? bithDate;
  @override
  final String? phone;
  @override
  final String? location;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'mobile_no')
  final String? mobileNo;

  @override
  String toString() {
    return 'LoggedInUser(name: $name, username: $username, firstName: $firstName, lastName: $lastName, apiKey: $apiKey, apiSecret: $apiSecret, email: $email, password: $password, roleProfileName: $roleProfileName, gender: $gender, bithDate: $bithDate, phone: $phone, location: $location, bio: $bio, mobileNo: $mobileNo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoggedInUserImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.apiKey, apiKey) || other.apiKey == apiKey) &&
            (identical(other.apiSecret, apiSecret) ||
                other.apiSecret == apiSecret) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.roleProfileName, roleProfileName) ||
                other.roleProfileName == roleProfileName) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.bithDate, bithDate) ||
                other.bithDate == bithDate) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.mobileNo, mobileNo) ||
                other.mobileNo == mobileNo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      username,
      firstName,
      lastName,
      apiKey,
      apiSecret,
      email,
      password,
      roleProfileName,
      gender,
      bithDate,
      phone,
      location,
      bio,
      mobileNo);

  /// Create a copy of LoggedInUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoggedInUserImplCopyWith<_$LoggedInUserImpl> get copyWith =>
      __$$LoggedInUserImplCopyWithImpl<_$LoggedInUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LoggedInUserImplToJson(
      this,
    );
  }
}

abstract class _LoggedInUser extends LoggedInUser {
  const factory _LoggedInUser(
      {required final String name,
      required final String username,
      @JsonKey(name: 'first_name', defaultValue: '')
      required final String firstName,
      @JsonKey(name: 'last_name', defaultValue: '')
      required final String lastName,
      @JsonKey(name: 'api_key', defaultValue: '') required final String apiKey,
      @JsonKey(name: 'api_secret', defaultValue: '')
      required final String apiSecret,
      @JsonKey(name: 'email', defaultValue: '') final String? email,
      @JsonKey(defaultValue: '') required final String password,
      @JsonKey(name: 'role_profile_name', defaultValue: '')
      final String? roleProfileName,
      @JsonKey(name: 'gender') final String? gender,
      @JsonKey(name: 'birth_date') final String? bithDate,
      final String? phone,
      final String? location,
      final String? bio,
      @JsonKey(name: 'mobile_no') final String? mobileNo}) = _$LoggedInUserImpl;
  const _LoggedInUser._() : super._();

  factory _LoggedInUser.fromJson(Map<String, dynamic> json) =
      _$LoggedInUserImpl.fromJson;

  @override
  String get name;
  @override
  String get username;
  @override
  @JsonKey(name: 'first_name', defaultValue: '')
  String get firstName;
  @override
  @JsonKey(name: 'last_name', defaultValue: '')
  String get lastName;
  @override
  @JsonKey(name: 'api_key', defaultValue: '')
  String get apiKey;
  @override
  @JsonKey(name: 'api_secret', defaultValue: '')
  String get apiSecret;
  @override
  @JsonKey(name: 'email', defaultValue: '')
  String? get email;
  @override
  @JsonKey(defaultValue: '')
  String get password;
  @override
  @JsonKey(name: 'role_profile_name', defaultValue: '')
  String? get roleProfileName;
  @override
  @JsonKey(name: 'gender')
  String? get gender;
  @override
  @JsonKey(name: 'birth_date')
  String? get bithDate;
  @override
  String? get phone;
  @override
  String? get location;
  @override
  String? get bio;
  @override
  @JsonKey(name: 'mobile_no')
  String? get mobileNo;

  /// Create a copy of LoggedInUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoggedInUserImplCopyWith<_$LoggedInUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
