import 'package:amplify_flutter/amplify_flutter.dart';

import '../Model.dart';

class Unit extends Model {
  final String id;
  final String _name;
  final String _sign;

  @override
  String getId() {
    return id;
  }

  String get name {
    return _name;
  }

  String get sign {
    return _sign;
  }

  const Unit._internal({
    required this.id,
    required name,
    required sign,
  })  : _name = name,
        _sign = sign;

  factory Unit({
    String? id,
    required String name,
    required String sign,
  }) {
    return Unit._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      sign: sign,
    );
  }

  Unit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = json['name'],
        _sign = json['sign'];

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': _name,
        'sign': _sign,
      };
}
