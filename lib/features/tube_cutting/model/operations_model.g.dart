// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OperationsModelImpl _$$OperationsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$OperationsModelImpl(
      data: (json['data'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, (e as List<dynamic>).map((e) => e as String).toList()),
          ) ??
          {},
    );

Map<String, dynamic> _$$OperationsModelImplToJson(
        _$OperationsModelImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
