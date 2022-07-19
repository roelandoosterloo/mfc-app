import 'package:amplify_flutter/amplify_flutter.dart' as amplify;
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

@immutable
class Option extends Model {
  final String id;
  final String _questionId;
  final String _label;
  final int? _index;

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

  int get index {
    return _index ?? 0;
  }

  const Option._internal(
      {required this.id, required questionId, required label, index})
      : _questionId = questionId,
        _label = label,
        _index = index;

  factory Option(
      {String? id,
      required String questionId,
      required String label,
      int? index}) {
    return Option._internal(
      id: id == null ? amplify.UUID.getUUID() : id,
      questionId: questionId,
      label: label,
      index: index,
    );
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
        _label = json['label'],
        _index = json['index'];

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
