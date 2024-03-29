import 'package:flutter/material.dart';
import 'package:mfc_app/models/Answer.dart';
import 'package:mfc_app/models/Option.dart';
import 'package:mfc_app/models/Question.dart';
import 'package:mfc_app/models/QuestionType.dart';

part "short_text.dart";
part "long_text.dart";
part "single_choice.dart";
part "multiple_choice.dart";

class QuestionW extends StatefulWidget {
  final Question question;
  final int index;
  final Function(String) onChange;
  final Answer? answer;
  final String? value;

  const QuestionW({
    Key? key,
    required this.question,
    required this.onChange,
    required this.index,
    this.answer,
    this.value,
  }) : super(key: key);

  @override
  State<QuestionW> createState() => _QuestionWState();
}

class _QuestionWState extends State<QuestionW> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if (widget.value != null &&
        (widget.question.type == QuestionType.SHORT_TEXT ||
            widget.question.type == QuestionType.LONG_TEXT)) {
      _controller.text = widget.value!;
    }
    _controller.addListener(() {
      if (_controller.text != widget.value) {
        widget.onChange(_controller.text);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 16,
            ),
            child: Text(
              "Vraag ${widget.index}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (widget.question.type == QuestionType.SHORT_TEXT)
            ShortTextQuestion(
              question: widget.question,
              controller: _controller,
            ),
          if (widget.question.type == QuestionType.LONG_TEXT)
            LongTextQuestion(
              question: widget.question,
              controller: _controller,
            ),
          if (widget.question.type == QuestionType.SINGLE_CHOICE)
            SingleChoiceQuestion(
              question: widget.question,
              onChange: widget.onChange,
              value: widget.value,
            ),
          if (widget.question.type == QuestionType.MULTIPLE_CHOICE)
            MultipleChoiceQuestion(
              question: widget.question,
              onChange: widget.onChange,
              value: widget.value,
            ),
          // renderAnswerSection(),
        ],
      ),
    );
  }
}
