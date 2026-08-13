import 'dart:convert';

import 'package:svs_operations/core/network/api_response.dart';
import 'package:svs_operations/core/network/exception.dart';

typedef ApiObjectParser<T> = T Function(Map<String, dynamic>);

abstract class ApiResponseParser<T> {
  ApiResponse<T> parse(
      String response, ApiObjectParser<T> parser, String defErrorMessage);
}

class FrappeApiResponseParser<T> implements ApiResponseParser<T> {
  @override
  ApiResponse<T> parse(
    String apiResponse,
    ApiObjectParser<T> parser,
    String defErrorMessage,
  ) {
    try {
      final Map<String, dynamic> response =
          json.decode(apiResponse) as Map<String, dynamic>;

      if (response['status'] == 400) {
        return ApiResponse.failure(response['message'].toString());
      }
      if (response.containsKey('message')) {
        final message = response['message'];
        if (message is List<dynamic>) {
          // if (message.every((element) => element is List<dynamic>)) {
          //   return ApiResponse.success(message);
          // }
          final result = parser(response);
          return ApiResponse.success(result);
        }
        if (message is String) {
          return ApiResponse.success(response as T);
        }
        final msgObj = message as Map<String, dynamic>;
        if (msgObj['status'] == 'success') {
          final result = parser(response);

          return ApiResponse.success(result);
        } else if (msgObj['status'] == 'error') {
          return ApiResponse.failure(msgObj['message']);
        }
        final status = msgObj['status'] as int? ?? 200;
        if (status == 200) {
          final result = parser(response);
          return ApiResponse.success(result);
        } else if (msgObj.containsKey('message') || status == 400) {
          final String message = msgObj['message'];
          return ApiResponse.failure(message);
        }
      } else if (response.containsKey('data')) {
        final result = parser(response);
        return ApiResponse.success(result);
      }

      throw UnExpectedResponseException(Errors.unrecognizedResponse);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }
}

class Errors {
  static String get noInternet => 'Please check your internet connection';
  static String get emptyApiResponse => 'Received empty response from server';
  static String get defaultApiErrorMessage =>
      'Unfortunately something went wrong. Please try again a moment later';
  static String get unknown => 'Unknown error occurred';
  static String get connectionIssue =>
      'Could not connect to server. Please check your internet';
  static String get internalServerError => 'Internal Server Error';
  static String get unauthorized =>
      'Looks like you do not have access to this information';
  static String get invalidcredentials =>
      'Wrong credentials. Invalid Username or Password';
  static String get clientError =>
      'Unfortunately we could not complete the request.';
  static String get responseIsNotValidJson => 'Invalid json response';
  static String get unrecognizedResponse => 'Unsupported response format';

  // Login
  static String get invalidUser => 'Invalid User';
}
