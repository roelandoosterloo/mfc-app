import 'package:flutter/material.dart';
import 'package:mfc_app/models/course/Option.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/models/course/QuestionType.dart';

part "short_text.dart";
part "long_text.dart";
part "single_choice.dart";
part "multiple_choice.dart";

class QuestionW extends StatefulWidget {
  final Question question;
  final int index;
  final Function(String) onChange;
  final String? value;

  const QuestionW({
    Key? key,
    required this.question,
    required this.onChange,
    required this.index,
    this.value,
  }) : super(key: key);

  @override
  State<QuestionW> createState() => _QuestionWState();
}

class _QuestionWState extends State<QuestionW> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
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
              "Question ${widget.index}",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Divider(
              color: Colors.white70,
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
