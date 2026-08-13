import 'package:svs_operations/core/logger/app_logger.dart';
import 'package:svs_operations/core/model/failure.dart';

Failure defaultErrorParser(Map<String, dynamic> response, String defErrorMessage) {
  try {
    if(response.containsKey('_server_messages')) {
      return Failure(error: response['exc_type'], title: 'Message');
    }
    late String errorMsg;
    if(response.containsKey('message')) {
      errorMsg = response['message'];
    } else {
      errorMsg = response['exception'];
      errorMsg = errorMsg.replaceAll('frappe.exceptions.', '');
    }
    final excType = response['exc_type'] as String?;
    final exception = response['exception'];
    final stachTrace = response['exc'];
    $logger.error('[Frappe $errorMsg]', exception, stachTrace);
    return Failure(title: excType, error: errorMsg);
  } on Exception catch (e, st) {
    $logger.error('[Error Parser]', e, st);
    throw const FormatException('Unrecognized json error response');
  }
}
