import 'package:intl/intl.dart';
import 'package:svs_operations/core/core.dart';

/// Shortcut for DateFormatUtil [DFU]
typedef DFU = DateFormatUtil;

abstract class _DateTimeFormats {
  static final dayName = DateFormat('EEE');
  static final dayNameFull = DateFormat('EEEE');
  static final ddMMyyyy = DateFormat('dd-MMM-yyyy');
  static final ddMMMyyyy = DateFormat('dd/MM/yyyy');
  static final friendlyFormat = DateFormat('dd-MM-yyyy');
  static final dateTimeLabel = DateFormat('MMM d, h:mm a');
  static final timeLabel = DateFormat('hh:mm a');
  static final hhMMss = DateFormat('HH:mm:ss');
  static final currentTimeFormat = DateFormat('dd-MMM-yyyy hh:mm a');
}

abstract class DateFormatUtil {
  static DateTime now() => DateTime.now();

  static String getDayName(DateTime dateTime) =>
      _DateTimeFormats.dayName.format(dateTime);

  static DateTime toDateTime(String date, [String format = 'dd/MM/yyyy']) =>
      DateFormat(format).parse(date);

  static String getDayNameFully(DateTime dateTime) =>
      _DateTimeFormats.dayNameFull.format(dateTime);
  static String ddMMyyyy(DateTime dateTime) =>
      _DateTimeFormats.ddMMyyyy.format(dateTime);
  static String ddMMMyyyy(DateTime dateTime) =>
      _DateTimeFormats.ddMMMyyyy.format(dateTime);
  static String friendlyFormat(DateTime dateTime) =>
      _DateTimeFormats.friendlyFormat.format(dateTime);
  static String dateTimeLabel(DateTime dateTime) =>
      _DateTimeFormats.dateTimeLabel.format(dateTime);
  static String hhMMss(DateTime dateTime) =>
      _DateTimeFormats.hhMMss.format(dateTime);
  static String currentTimeFormat(DateTime dateTime) =>
      _DateTimeFormats.currentTimeFormat.format(dateTime);
  static String ddMMyyyyFromStr(String date) {
    try {
      final dateTime = DateTime.parse(date);
      return _DateTimeFormats.ddMMyyyy.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static String timeLabelFromStr(String date) {
    try {
      final dateTime = DateTime.parse(date);
      return _DateTimeFormats.timeLabel.format(dateTime);
    } catch (e) {
      return '';
    }
  }

  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  static String? addTimeOffset(String? time) {
    if (time == null || time.isEmpty) return '';
    final tempTime = DateFormat("HH:mm:ss").parse(time);
    final updatedTime = tempTime.add(const Duration(hours: 5, minutes: 30));
    return DateFormat('HH:mm a').format(updatedTime);
  }

  static String? toPostDate(final String? date) {
    if(date.isNull) return null;

    final dobObj = DateFormat('dd-MM-yyyy').parse(date!);
    final d = DateFormat('yyyy-MM-dd').format(dobObj);
        return d;

  }
}
