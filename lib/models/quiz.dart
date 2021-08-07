class Option {
  String value;
  String label;

  Option(this.value, {label}) : label = label ?? value;

  Option.fromJson(Map<String, dynamic> json)
      : this(
          json['value'],
          label: json['label'],
        );
}

enum QuestionType {
  shortText,
  longText,
  singleChoice,
  multipleChoice,
}

class Question {
  String _id;
  String _questionText;
  QuestionType _type;
  List<Option>? _options;

  Question({
    required String id,
    required String questionText,
    required QuestionType type,
    List<Option>? options,
  })  : _id = id,
        _questionText = questionText,
        _type = type,
        _options = options;

  String get id => _id;
  String get questionText => _questionText;
  QuestionType get type => _type;
  List<Option>? get options => _options;

  Question.fromJson(String id, Map<String, dynamic> json)
      : this(
          id: id,
          questionText: json['questionText'],
          type: QuestionType.values.firstWhere((element) =>
              element.toString() == 'QuestionType.' + json['type']),
          options: json['options'] != null
              ? (json['options'] as List)
                  .map((item) => Option.fromJson(item))
                  .toList()
              : null,
        );
}
