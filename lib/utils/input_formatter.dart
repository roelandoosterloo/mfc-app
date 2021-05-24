import 'package:flutter/services.dart';

TextInputFormatter buildDecimalFormatter({int precision = 2}) {
  return FilteringTextInputFormatter.allow(
      RegExp(r'^\d+\.?\d{0,' + precision.toString() + '}'));
}
