part of "question.dart";

class SingleChoiceQuestion extends StatelessWidget {
  final Question _question;
  final Function(String) _onChange;
  final String? _value;

  const SingleChoiceQuestion({
    Key? key,
    required Question question,
    required Function(String) onChange,
    String? value,
  })  : _question = question,
        _onChange = onChange,
        _value = value,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _question.question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_question.introduction != null) Text(_question.introduction!),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: (_question.options ?? [])
                .map(
                  (Option opt) => RadioListTile<String>(
                    value: opt.label,
                    title: Text(opt.label),
                    groupValue: _value,
                    onChanged: (value) => _onChange(value ?? ""),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
