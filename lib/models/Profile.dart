import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/models/Model.dart';

@immutable
class Profile extends Model {
  final String id;
  final String _firstName;
  final String _lastName;
  final DateTime? _birthDate;
  final double? _length;
  final double? _targetWeight;

  static final DateFormat _dateFormat = new DateFormat('yyyy-MM-dd');

  String get firstName {
    return _firstName;
  }

  String get lastName {
    return _lastName;
  }

  DateTime? get birthDate {
    return _birthDate;
  }

  double? get length {
    return _length;
  }

  double? get targetWeight {
    return _targetWeight;
  }

  String? get formattedBirthdate {
    if (_birthDate != null) {
      return _dateFormat.format(_birthDate!);
    }
  }

  const Profile._internal({
    required this.id,
    required String firstName,
    required String lastName,
    DateTime? birthDate,
    double? length,
    double? targetWeight,
  })  : _firstName = firstName,
        _lastName = lastName,
        _birthDate = birthDate,
        _length = length,
        _targetWeight = targetWeight;

  factory Profile({
    String? id,
    required String firstName,
    required String lastName,
    DateTime? birthDate,
    double? length,
    double? targetWeight,
  }) {
    return Profile._internal(
      id: id ?? UUID.getUUID(),
      firstName: firstName,
      lastName: lastName,
      birthDate: birthDate,
      length: length,
      targetWeight: targetWeight,
    );
  }

  @override
  String getId() {
    return id;
  }

  Profile update({
    String? firstName,
    String? lastName,
    DateTime? birthDate,
    double? length,
    double? targetWeight,
  }) {
    return Profile(
      id: this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDate: birthDate ?? this.birthDate,
      length: length ?? this.length,
      targetWeight: targetWeight ?? this.targetWeight,
    );
  }

  Profile.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _firstName = json['firstName'],
        _lastName = json['lastName'],
        _birthDate = json['birthDate'] != null
            ? _dateFormat.parse(json['birthDate'])
            : null,
        _length = json['length'] != null ? json['length'].toDouble() : null,
        _targetWeight = json['targetWeight'] != null
            ? json['targetWeight'].toDouble()
            : null;

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'birthDate': birthDate != null ? _dateFormat.format(birthDate!) : null,
        'length': length,
        'targetWeight': targetWeight,
      };
}
