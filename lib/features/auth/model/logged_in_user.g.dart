// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logged_in_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LoggedInUserImpl _$$LoggedInUserImplFromJson(Map<String, dynamic> json) =>
    _$LoggedInUserImpl(
      name: json['name'] as String,
      username: json['username'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      apiKey: json['api_key'] as String? ?? '',
      apiSecret: json['api_secret'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      roleProfileName: json['role_profile_name'] as String? ?? '',
      gender: json['gender'] as String?,
      bithDate: json['birth_date'] as String?,
      phone: json['phone'] as String?,
      location: json['location'] as String?,
      bio: json['bio'] as String?,
      mobileNo: json['mobile_no'] as String?,
    );

Map<String, dynamic> _$$LoggedInUserImplToJson(_$LoggedInUserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'api_key': instance.apiKey,
      'api_secret': instance.apiSecret,
      'email': instance.email,
      'password': instance.password,
      'role_profile_name': instance.roleProfileName,
      'gender': instance.gender,
      'birth_date': instance.bithDate,
      'phone': instance.phone,
      'location': instance.location,
      'bio': instance.bio,
      'mobile_no': instance.mobileNo,
    };
