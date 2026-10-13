// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_roles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserRolesImpl _$$UserRolesImplFromJson(Map<String, dynamic> json) =>
    _$UserRolesImpl(
      sfgOperations:
          (json['Show SFG Operations in Mobile App'] as num?)?.toInt() ?? 0,
      fgOperations:
          (json['Show FG Operations in Mobile App'] as num?)?.toInt() ?? 0,
      exit: (json['Show Gate Exit in Mobile App'] as num?)?.toInt() ?? 0,
      entry: (json['Show Gate Entry in Mobile App'] as num?)?.toInt() ?? 0,
      operations: (json['Show Operations in Mobile App'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$UserRolesImplToJson(_$UserRolesImpl instance) =>
    <String, dynamic>{
      'Show SFG Operations in Mobile App': instance.sfgOperations,
      'Show FG Operations in Mobile App': instance.fgOperations,
      'Show Gate Exit in Mobile App': instance.exit,
      'Show Gate Entry in Mobile App': instance.entry,
      'Show Operations in Mobile App': instance.operations,
    };
