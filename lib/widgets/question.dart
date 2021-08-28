import 'package:flutter/material.dart';
import 'package:mfc_app/models/course/Option.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/models/course/QuestionType.dart';

class QuestionW extends StatelessWidget {
  final Question question;

  const QuestionW({Key? key, required this.question}) : super(key: key);

  Widget renderAnswerSection() {
    if (question.type == QuestionType.SHORT_TEXT) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: question.question,
        ),
      );
    } else if (question.type == QuestionType.LONG_TEXT) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: question.question,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      );
    } else if (question.type == QuestionType.SINGLE_CHOICE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(question.options ?? [])
              .map(
                (Option opt) => RadioListTile(
                  value: opt.value,
                  title: Text(opt.label ?? opt.value),
                  groupValue: "answer",
                  onChanged: (value) => null,
                ),
              )
              .toList()
        ],
      );
    } else if (question.type == QuestionType.MULTIPLE_CHOICE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(question.options ?? [])
              .map(
                (Option opt) => CheckboxListTile(
                  value: false,
                  title: Text(opt.label ?? opt.value),
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
