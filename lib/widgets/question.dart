import 'package:flutter/material.dart';
import 'package:mfc_app/models/course/Option.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/models/course/QuestionType.dart';

class QuestionW extends StatefulWidget {
  final Question question;
  final int index;
  final VoidCallback onChange;

  const QuestionW({
    Key? key,
    required this.question,
    required this.onChange,
    required this.index,
  }) : super(key: key);

  @override
  State<QuestionW> createState() => _QuestionWState();
}

class _QuestionWState extends State<QuestionW> {
  String? selectedValue = "";
  List<String> selectedValues = [];

  Widget renderAnswerSection() {
    if (widget.question.type == QuestionType.SHORT_TEXT) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: widget.question.question,
        ),
      );
    } else if (widget.question.type == QuestionType.LONG_TEXT) {
      return TextFormField(
        decoration: InputDecoration(
          labelText: widget.question.question,
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
      );
    } else if (widget.question.type == QuestionType.SINGLE_CHOICE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(widget.question.options ?? [])
              .map(
                (Option opt) => RadioListTile<String>(
                  value: opt.label,
                  title: Text(opt.label),
                  groupValue: selectedValue,
                  onChanged: (value) => setState(() {
                    selectedValue = value;
                  }),
                  // selected: isSelected(opt.label),
                ),
              )
              .toList()
        ],
      );
    } else if (widget.question.type == QuestionType.MULTIPLE_CHOICE) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          ...(widget.question.options ?? [])
              .map(
                (Option opt) => CheckboxListTile(
                  title: Text(opt.label),
                  value: selectedValues.contains(opt.label),
                  onChanged: (value) => setState(() {
                    if (value != null && value) {
                      selectedValues.add(opt.label);
                    } else {
                      selectedValues.remove(opt.label);
                    }
                  }),
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              )
              .toList()
        ],
      );
    } else {
      return Text("question type ${widget.question.type} not supported");
    }
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
          if (widget.question.introduction != null)
            Text(widget.question.introduction!),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(),
          ),
          renderAnswerSection(),
        ],
      ),
    );
  }
}
