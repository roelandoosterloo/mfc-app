import 'package:intl/intl.dart';
import 'package:mfc_app/constants/values.dart';

class Formatter {
  static final _localDateFormat = new DateFormat.yMd(Intl.getCurrentLocale());
  static final _singleDecimal =
      new NumberFormat(SINGLE_DECIMAL_FORMAT, Intl.getCurrentLocale());
  static final _doubleDecimal =
      new NumberFormat(DOUBLE_DECIMAL_FORMAT, Intl.getCurrentLocale());

  static String? formatDate(DateTime? date) {
    if (date == null) {
      return null;
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
