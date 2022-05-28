import 'package:amplify_flutter/amplify_flutter.dart' as amplify;
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

@immutable
class Answer extends Model {
  final String id;
  final String _questionId;
  final String _moduleProgressId;
  final String _answer;

  @override
  String getId() {
    return id;
  }

  String get questionId {
    return _questionId;
  }

  String get answer {
    return _answer;
  }

  String get moduleProgressId {
    return _moduleProgressId;
  }

  const Answer._internal({
    required this.id,
    required questionId,
    required moduleProgressId,
    required answer,
  })  : _questionId = questionId,
        _answer = answer,
        _moduleProgressId = moduleProgressId;

  factory Answer({
    String? id,
    required String questionId,
    required String answer,
    required String moduleProgressId,
  }) {
    return Answer._internal(
      id: id == null ? amplify.UUID.getUUID() : id,
      questionId: questionId,
      answer: answer,
      moduleProgressId: moduleProgressId,
    );
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Answer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("questionId=" + "$_questionId" + ", ");
    buffer.write("answer=" + "$_answer" + ", ");
    buffer.write("}");

    return buffer.toString();
  }

  Answer.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _questionId = json['questionId'],
        _answer = json['answer'],
        _moduleProgressId = json['moduleProgressId'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionId': _questionId,
        'moduleProgressId': _moduleProgressId,
        'answer': _answer,
      };

  @override
  bool operator ==(Object other) =>
      other is Answer &&
      id == other.id &&
      _questionId == other.questionId &&
      _moduleProgressId == other.moduleProgressId &&
      _answer == other.answer;

  @override
  int get hashCode => super.hashCode;
}
