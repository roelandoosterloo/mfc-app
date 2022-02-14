import 'package:intl/intl.dart';

class Parser {
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
        double? v =
            NumberFormat(Intl.getCurrentLocale()).parse(value) as double?;
        return v;
      } catch (_) {
        return double.tryParse(value);
      }
    }
    return null;
  }
}
