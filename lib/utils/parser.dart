import 'dart:io';

import 'package:amplify_flutter/amplify_flutter.dart';
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

  static TemporalDate? readDateLocalToTemporal(Object? value) {
    DateTime? date = readDateLocal(value);
    if (date == null) return null;

    return TemporalDate(date);
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
        double? v;
        if (RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value)) {
          v = NumberFormat.decimalPattern('en_US').parse(value) as double?;
        } else {
          v = NumberFormat.decimalPattern('nl_NL').parse(value) as double?;
        }
        return v;
      } catch (_) {
        return double.tryParse(value);
      }
    }
    return null;
  }
}
