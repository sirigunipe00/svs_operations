import 'package:svs_operations/core/di/injector.dart';

final _reqisteredUrl = $sl.get<Urls>(instanceName: 'baseUrl');

class Urls {
  factory Urls.aparnaUAT() =>
      const Urls('https://svserpnextuat.easycloud.co.in/api');
  factory Urls.local() =>
      const Urls('https://svserpnextuat.easycloud.co.in/api');
  factory Urls.aparnaLive() =>
      const Urls('https://aparnagmlive.easycloud.co.in/api');

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

  static final appUpdate = '$cusWs/easy_common.api.get_app_version';

  static final login = '$cusWs/svserpnext.api.getUsers';

  static final jobCard = '$jsonWs/Job Card';
  static final userOperations = '$cusWs/svserpnext.api.get_user_operations';
  static final addItem = '$cusWs/svserpnext.api.add_time_log';
  static final updateItem = '$cusWs/svserpnext.api.update_time_log';

  static final getList = '$cusWs/frappe.client.get_list';

  static final gateEntryList = '$cusWs/easygateentry.api.getGateEntry';
  static final getGateEntry = '$cusWs/easygateentry.api.getGateEntryDetails';
  static final newGateEntry = '$cusWs/easygateentry.api.createGateEntry';
  static final submitGateEntry = '$cusWs/easygateentry.api.submitGateEntry';

  static final gateExitList = '$cusWs/easygateentry.api.getGateExit';
  static final getGateExit = '$cusWs/easygateentry.api.getGateExitDetails';
  static final newGateExit = '$cusWs/easygateentry.api.createGateExit';
  static final submitGateExit = '$cusWs/easygateentry.api.submitGateExit';
  static final getVehicleNumber =
      '$cusWs/easygateentry.api.getvehiclenumberfromsalesinvoice';
  static final poList = '$cusWs/easygateentry.api.po_list';

  static filepath(String path) {
    return '${baseUrl.replaceAll('api', '')}/${path.replaceAll('/private', '').replaceAll("///", '/')}';
  }
}
