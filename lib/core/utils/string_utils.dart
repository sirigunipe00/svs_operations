import 'package:svs_operations/core/core.dart';
import 'package:dartz/dartz.dart';

class StringUtils {
  static bool equals(String? str1, String? str2) {
    if (str1 == null || str2 == null) return false;
    return str1 == str2;
  }

  static bool equalsIgnoreCase(String? str1, String? str2) {
    if (str1 == null || str2 == null) return false;
    return str1.trim().toLowerCase() == str2.trim().toLowerCase();
  }

  static String concat(String? s1, [String? s2, String? s3]) {
    return [s1, s2, s3].where((e) => !e.isNull).join('');
  }

  static String trimTime(String? s1) {
    if (s1.doesNotHaveValue) return '';
    return RegExp(r'^\d{2}:\d{2}:\d{2}').stringMatch(s1!) ?? s1;
  }

  static String docStatus(int status) {
    if (status == 0) {
      return 'Draft';
    } else if (status == 1) {
      return 'Submitted';
    } else {
      return 'Draft';
    }
  }

  static int docStatusInt(String status) {
    if (status == 'Draft') {
      return 0;
    } else if (status == 'Submitted') {
      return 1;
    } else {
      return 0;
    }
  }

  static String docId(String input) {
    RegExp regExp = RegExp(r'RR-\d+');
    String? result = regExp.stringMatch(input);

    if (result != null) {
      return result;
    } else {
      return '';
    }
  }
}

extension StringExentions on String? {
  bool get containsValidValue =>
      this != null && (this!.trim().isNotEmpty) && this!.trim() != 'null';

  bool get doesNotHaveValue => !containsValidValue;

  String get valueOrEmpty => this ?? '';

  Either<Failure, T> asFailure<T>() => left(Failure(error: this!));

  bool equals(String? str) => StringUtils.equals(this, str);

  bool equalsIgnoreCase(String? str) => StringUtils.equals(this, str);

  bool get isValidNum => containsValidValue && num.tryParse(this!) != null;

  String concat([String? s2, String? s3]) => StringUtils.concat(this, s2, s3);

  bool get isSVG => containsValidValue && this!.split('.').last == 'svg';

  bool containsIgnoreCase(String? other) {
    if (this == null || other == null) {
      return false;
    }
    return this!.toLowerCase().contains(other.toLowerCase());
  }
}
