import 'dart:io';

import 'package:intl/intl.dart';

class Parser {
  static DateTime? readDateUtc(Object? value) {
    if (value == null) return null;
    if (value is String) {
      DateFormat f = new DateFormat.yMd(Platform.localeName);
      return f.parseUtc(value);
    }
    return null;
  }

  static DateTime? readDateLocal(Object? value) {
    if (value == null) return null;
    if (value == "") return null;
    if (value is String) {
      DateFormat f = new DateFormat.yMd(Platform.localeName);
      return f.parse(value);
    }
    return null;
  }

  static double? readDouble(Object? value) {
    if (value == null) {
      return null;
    }
    if (value is double) {
      return value;
    }
    if (value is int) {
      return value.toDouble();
    }
    if (value is String) {
      try {
        // instead of a proper localized version, use a forced format
        // double? v = NumberFormat.decimalPattern(Platform.localeName)
        // .parse(value) as double?;
        double? v =
            NumberFormat.decimalPattern("nl_NL").parse(value) as double?;
        return v;
      } catch (_) {
        return double.tryParse(value);
      }
    }
    return null;
  }
}
