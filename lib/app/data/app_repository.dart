import 'package:svs_operations/app/data/app_version.dart';
import 'package:svs_operations/core/consts/urls.dart';
import 'package:svs_operations/core/model/failure.dart';
import 'package:svs_operations/core/network/base_api_repo.dart';
import 'package:svs_operations/core/network/request_config.dart';
import 'package:svs_operations/core/utils/utils.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppRepository extends BaseApiRepository {
  AppRepository(super.client, this.appVersion);

  final AppVersion appVersion;

  Future<Either<Failure, bool>> isAppUpdateAvailable() async {
    final requestConfig = RequestConfig(
      url: Urls.appUpdate,
      parser: (p0) => p0,
    );
    final response = await post(requestConfig, includeAuthHeader: false);

    return await response.processAsync((r) async {
      final responseData = r.data!;
      final data = responseData['data'];

      if (data['status'] == 400) {
        return left(Failure(error: data['message']));
      }
      final serverVersion = data['app_version'];
      final appVersionStr = await appVersion.getAppVersion();
      if (appVersionStr.compareTo(serverVersion) < 0) {
        return right(true);
      }
      return right(false);
    });
  }
}
