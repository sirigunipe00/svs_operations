import 'package:svs_operations/core/di/injector.dart';

final _reqisteredUrl = $sl.get<Urls>(instanceName: 'baseUrl');

class Urls {
  factory Urls.aparnaUAT() =>
      const Urls('https://aparnagmuat.easycloud.co.in/api');
      factory Urls.local() => const Urls('https://svserpnextuat.easycloud.co.in/api');
  factory Urls.aparnaLive() => const Urls('https://aparnagmlive.easycloud.co.in/api');

  const Urls(this.url);

  final String url;

  static bool get isTest => Uri.parse(_reqisteredUrl.url)
      .authority
      .split('.')
      .first
      .toLowerCase()
      .contains('uat');

  static final baseUrl = _reqisteredUrl.url;
  static final jsonWs = '$baseUrl/resource';
  static final cusWs = '$baseUrl/method';
  static final uploadFiles = '$cusWs/svs_operations.api.upload_files';

  static final appUpdate ='$cusWs/easy_common.api.get_app_version';

  static final login = '$cusWs/svserpnext.api.getUsers';




  static filepath(String path) {
    return '${baseUrl.replaceAll('api', '')}/${path.replaceAll('/private', '').replaceAll("///", '/')}';
  }
}
