import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mfc_app/constants/values.dart';

class Formatter {
  static String locale =
      "nl_NL"; // Platform.localeName; // <-- actual value, disabled for stupid users
  static DateFormat _localDateFormat = new DateFormat.yMd(locale);
  static NumberFormat _singleDecimal =
      new NumberFormat(SINGLE_DECIMAL_FORMAT, locale);
  static NumberFormat _doubleDecimal =
      new NumberFormat(DOUBLE_DECIMAL_FORMAT, locale);

  static String? formatDate(DateTime? date, {String? datePattern}) {
    if (date == null) {
      return null;
    }
    if (datePattern != null) {
      return new DateFormat(datePattern, locale).format(date);
    }
    return _localDateFormat.format(date);
  }

  static String? formatDecimal(double? number, {int? decimals}) {
    if (number == null) {
      return null;
    }
    if (decimals == 2) {
      return _doubleDecimal.format(number);
    }
    return _singleDecimal.format(number);
  }
}
