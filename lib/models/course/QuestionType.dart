enum QuestionType {
  SHORT_TEXT,
  LONG_TEXT,
  SINGLE_CHOICE,
  MULTIPLE_CHOICE,
}

extension QuestionTypeExtendsion on QuestionType {
  String get name {
    return this.toString().split('.').last;
  }
}
