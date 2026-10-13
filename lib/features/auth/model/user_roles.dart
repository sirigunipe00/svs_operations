import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_roles.freezed.dart';
part 'user_roles.g.dart';

@freezed
class UserRoles with _$UserRoles {
  const UserRoles._();
  const factory UserRoles({
    @JsonKey(name: 'Show SFG Operations in Mobile App', defaultValue: 0) required int sfgOperations,
    @JsonKey(name: 'Show FG Operations in Mobile App', defaultValue: 0) required int fgOperations,
    @JsonKey(name: 'Show Gate Exit in Mobile App', defaultValue: 0)  required int exit,
    @JsonKey(name: 'Show Gate Entry in Mobile App',defaultValue: 0) required int entry,
    @JsonKey(name: 'Show Operations in Mobile App',defaultValue: 0) required int operations,
  }) = _UserRoles;

  factory UserRoles.fromJson(Map<String, dynamic> json) =>
      _$UserRolesFromJson(json);
}
