import 'dart:io';

import 'package:svs_operations/core/cubit/base/app_task_either.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/model/logged_in_user.dart';
import 'package:dartz/dartz.dart';

typedef ApiCall<T> = Future<ApiResponse<T>> Function(RequestConfig<T> config);
typedef StandardApiResponse<T> = Future<Either<Failure, ApiResponse<T>>>;

class BaseApiRepository {
  const BaseApiRepository(this.client);

  final ApiClient client;

  StandardApiResponse<T> get<T>(RequestConfig<T> params,
      {bool includeAuthHeader = true}) async {
    try {
      return _request(client.get, params, includeAuthHeader: includeAuthHeader);
    } on Exception catch (e, st) {
      $logger.error('[Api Failure]', e, st);
      return left(Failure(error: e.toString()));
    }
  }

  StandardApiResponse<T> post<T>(
    RequestConfig<T> params, {
    bool includeAuthHeader = true,
  }) async {
    final headers = {...params.headers ?? {}}
      ..putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
    final paramsWithHeaders = params.copyWith(headers: headers);
    return _request(client.post, paramsWithHeaders,
        includeAuthHeader: includeAuthHeader);
  }

  StandardApiResponse<T> multiPart<T>(
    RequestConfig<T> params, {
    bool includeAuthHeader = true,
  }) async {
    return _request(client.multipartRequest, params,
        includeAuthHeader: includeAuthHeader);
  }

  StandardApiResponse<T> _request<T>(
      ApiCall<T> apiCall, RequestConfig<T> config,
      {bool includeAuthHeader = true}) async {
    try {
      final commonHeaders = <String, dynamic>{
        HttpHeaders.contentTypeHeader: 'application/json'
      };
      if (includeAuthHeader) {
        final cookie = await _getAuthCookie();
        commonHeaders.addAll(cookie);
      }
      final RequestConfig<T> requestConfig = config.copyWith(
        headers: {...config.headers ?? {}, ...commonHeaders},
      );

      final ApiResponse<T> response = await apiCall(requestConfig);
      if (response.isFailed()) {
        return left(Failure(error: response.error!, title: 'Message'));
      }

      return right(response);
    } on BaseApiException catch (e, st) {
      $logger.error(e.toString(), e, st);

      return left(Failure(error: e.message));
    } on Exception catch (e, st) {
      $logger.error(e.toString(), e, st);

      return left(Failure(error: e.toString()));
    }
  }

  AsyncValueOf<T> executeSafely<T>(AsyncValueOf<T> Function() asyncFunction) {
    return AppTaskEither.tryCatch(
      () async {
        final result = await asyncFunction();
        return result.fold((failure) => throw failure.error, (value) => value);
      },
      (error, stack) {
        $logger
          ..error('[BaseApiRepo]', error, stack)
          ..info(stack);
        return Failure(error: error.toString());
      },
    ).run();
  }

  Future<Map<String, dynamic>> _getAuthCookie() async {
    final apiKey = user().apiKey;
    final apiSecret = user().apiSecret;
    if (apiKey.doesNotHaveValue || apiSecret.doesNotHaveValue) return {};

    return {HttpHeaders.authorizationHeader: 'token $apiKey:$apiSecret'};
  }

  Map<String, dynamic> removeNullValues(Map<String, dynamic> map) {
    map.removeWhere((key, value) => value == null);
    Map<String, dynamic> stringifiedMap = {};

    map.forEach((key, value) {
      if (value is! File) {
        stringifiedMap[key] = value;
      } else {
        stringifiedMap[key] = value;
      }
    });
    return stringifiedMap;
  }

  LoggedInUser user() => $sl.get<LoggedInUser>();
}
