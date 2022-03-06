import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

@immutable
class Option extends Model {
  final String id;
  final String _questionId;
  final String _label;

  @override
  String getId() {
    return id;
  }

  String get questionId {
    return _questionId;
  }

  String get label {
    return _label;
  }

  const Option._internal(
      {required this.id, required questionId, required label})
      : _questionId = questionId,
        _label = label;

  factory Option(
      {String? id, required String questionId, required String label}) {
    return Option._internal(
        id: id == null ? UUID.getUUID() : id,
        questionId: questionId,
        label: label);
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Option {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("questionId=" + "$_questionId" + ", ");
    buffer.write("label=" + "$_label" + ", ");
    buffer.write("}");

    return buffer.toString();
  }

  Option.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _questionId = json['questionId'],
        _label = json['label'];

  Map<String, dynamic> toJson() =>
      {'id': id, 'questionId': _questionId, 'label': _label};

  @override
  bool operator ==(Object other) =>
      other is Option &&
      id == other.id &&
      _questionId == other.questionId &&
      _label == other.label;

  @override
  int get hashCode => super.hashCode;
}
