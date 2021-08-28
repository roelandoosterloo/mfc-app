import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

@immutable
class Option extends Model {
  final String id;
  final String _questionId;
  final String? _label;
  final String _value;

  @override
  String getId() {
    return id;
  }

  String get questionId {
    return _questionId;
  }

  String? get label {
    return _label;
  }

  String get value {
    return _value;
  }

  const Option._internal(
      {required this.id, required questionId, label, required value})
      : _questionId = questionId,
        _label = label,
        _value = value;

  factory Option(
      {String? id,
      required String questionId,
      String? label,
      required String value}) {
    return Option._internal(
        id: id == null ? UUID.getUUID() : id,
        questionId: questionId,
        label: label,
        value: value);
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Option {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("questionId=" + "$_questionId" + ", ");
    buffer.write("label=" + "$_label" + ", ");
    buffer.write("value=" + "$_value");
    buffer.write("}");

    return buffer.toString();
  }

  Option.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _questionId = json['questionId'],
        _label = json['label'],
        _value = json['value'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'questionId': _questionId, 'label': _label, 'value': _value};
}
