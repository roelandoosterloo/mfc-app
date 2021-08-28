import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';

import '../Model.dart';
import 'Option.dart';
import 'QuestionType.dart';

@immutable
class Question extends Model {
  final String id;
  final String _moduleId;
  final QuestionType _type;
  final String _question;
  final List<Option>? _options;

  @override
  String getId() {
    return id;
  }

  String get moduleId {
    return _moduleId;
  }

  QuestionType get type {
    return _type;
  }

  String get question {
    return _question;
  }

  List<Option>? get options {
    return _options;
  }

  const Question._internal(
      {required this.id,
      required moduleId,
      required type,
      required question,
      options})
      : _moduleId = moduleId,
        _type = type,
        _question = question,
        _options = options;

  factory Question(
      {String? id,
      required String moduleId,
      required QuestionType type,
      required String question,
      List<Option>? options}) {
    return Question._internal(
        id: id == null ? UUID.getUUID() : id,
        moduleId: moduleId,
        type: type,
        question: question,
        options:
            options != null ? List<Option>.unmodifiable(options) : options);
  }
  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Question {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("moduleId=" + "$_moduleId" + ", ");
    buffer.write("type=" + type.name + ", ");
    buffer.write("question=" + "$_question");
    buffer.write("}");

    return buffer.toString();
  }

  Question.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _moduleId = json['moduleId'],
        _type = QuestionType.values
            .firstWhere((element) => element.name == json['type']),
        _question = json['question'],
        _options = json['options']?['items'] is List
            ? (json['options']['items'] as List)
                .map((e) => Option.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'moduleId': _moduleId,
        'type': _type.name,
        'question': _question,
        'options': _options?.map((e) => e.toJson()).toList()
      };
}
