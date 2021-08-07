import 'package:flutter/material.dart';
import 'package:mfc_app/models/quiz.dart' as quiz;

class Question extends StatelessWidget {
  final quiz.Question question;

  const Question({Key? key, required this.question}) : super(key: key);

  Widget renderAnswerSection() {
    if (question.type == quiz.QuestionType.shortText) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: question.questionText,
        ),
      );
    } else if (question.type == quiz.QuestionType.longText) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: question.questionText,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      );
    } else if (question.type == quiz.QuestionType.singleChoice) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(question.options ?? [])
              .map(
                (quiz.Option opt) => RadioListTile(
                  value: opt.value,
                  title: Text(opt.label),
                  groupValue: "answer",
                  onChanged: (value) => null,
                ),
              )
              .toList()
        ],
      );
    } else if (question.type == quiz.QuestionType.multipleChoice) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.questionText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(question.options ?? [])
              .map(
                (quiz.Option opt) => CheckboxListTile(
                  value: false,
                  title: Text(opt.label),
                  onChanged: (value) => null,
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              )
              .toList()
        ],
      );
    } else {
      return Text("dolorme");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: renderAnswerSection(),
    );
  }
}
