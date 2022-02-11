import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/constants/values.dart';

import 'Model.dart';

@immutable
class Measurement extends Model {
  final String id;
  final DateTime _date;
  final double _weight;
  final String? _note;
  final String _type = "Measurement";

  static final DateFormat _dateFormat = new DateFormat("yyyy-MM-dd");

  @override
  String getId() {
    return id;
  }

  DateTime get date {
    return _date;
  }

  String get formatDate {
    return _dateFormat.format(_date);
  }

  double get weight {
    return _weight;
  }

  String? get note {
    return _note;
  }

  String get type {
    return _type;
  }

  const Measurement._internal(
      {required this.id, required date, required weight, note})
      : _date = date,
        _weight = weight,
        _note = note;

  factory Measurement(
      {String? id,
      required DateTime date,
      required double weight,
      String? note}) {
    return Measurement._internal(
        id: id == null ? UUID.getUUID() : id,
        date: date,
        weight: weight,
        note: note);
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Measurement {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date=" + _dateFormat.format(date) + ", ");
    buffer.write("weight=" + _weight.toString() + ", ");
    buffer.write("note=" + "$_note");
    buffer.write("}");

    return buffer.toString();
  }

  Measurement.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _date = _dateFormat.parse(json['date']),
        _weight = json['weight'].toDouble(),
        _note = json['note'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': _dateFormat.format(_date),
        'weight': _weight,
        'note': _note,
        'type': _type,
      };
}
