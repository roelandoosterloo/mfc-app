import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mfc_app/utils/parser.dart';

class Measurement {
  DateTime _date;
  double _weight;
  double? _hips;
  double? _waist;
  String? _note;

  Measurement({
    required DateTime date,
    required double weight,
    double? hips,
    double? waist,
    String? note,
  })  : _date = date,
        _weight = weight,
        _hips = hips,
        _waist = waist,
        _note = note;

  DateTime get date => _date;
  double get weight => _weight;
  double? get hips => _hips;
  double? get waist => _waist;
  String? get note => _note;

  Measurement.fromJson(Map<String, Object?> json)
      : this(
          date: (json['date']! as Timestamp).toDate(),
          weight: Parser.readDouble(json['weight']!)!,
          hips: Parser.readDouble(json['hips']),
          waist: Parser.readDouble(json['waist']),
          note: json['note'] as String,
        );

  Map<String, Object?> toJson() {
    return {
      'date': date,
      'weight': weight,
      'hips': hips,
      'waist': waist,
      'note': note,
    };
  }
}
