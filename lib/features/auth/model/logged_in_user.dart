import 'package:freezed_annotation/freezed_annotation.dart';

part 'logged_in_user.freezed.dart';
part 'logged_in_user.g.dart';

@freezed
class LoggedInUser with _$LoggedInUser {
  const LoggedInUser._();
  const factory LoggedInUser({
    required String name,
    required String username,
    @JsonKey(name: 'first_name', defaultValue: '') required String firstName,
    @JsonKey(name: 'last_name', defaultValue: '') required String lastName,
    @JsonKey(name: 'api_key', defaultValue: '') required String apiKey,
    @JsonKey(name: 'api_secret', defaultValue: '') required String apiSecret,
    @JsonKey(name: 'email', defaultValue: '') String? email,
    @JsonKey(defaultValue: '') required String password,
    @JsonKey(name: 'role_profile_name', defaultValue: '') String? roleProfileName,
    @JsonKey(name: 'gender') String? gender,
    @JsonKey(name: 'birth_date') String? bithDate,
    String? phone,
    String? location,
    String? bio,
    @JsonKey(name: 'mobile_no') String? mobileNo,
  }) = _LoggedInUser;

  factory LoggedInUser.fromJson(Map<String, dynamic> json) =>
      _$LoggedInUserFromJson(json);
}
