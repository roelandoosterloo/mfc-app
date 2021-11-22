part of "question.dart";

class MultipleChoiceQuestion extends StatelessWidget {
  final Question _question;
  final Function(String) _onChange;
  final String? _value;

  const MultipleChoiceQuestion({
    Key? key,
    required Question question,
    required Function(String) onChange,
    String? value,
  })  : _question = question,
        _onChange = onChange,
        _value = value,
        super(key: key);

  List<String> get values {
    return _value?.split(";") ?? [];
  }

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
                  (Option opt) => CheckboxListTile(
                    title: Text(opt.label),
                    value: values.contains(opt.label),
                    onChanged: (value) {
                      List<String> newvalues = values;
                      if (value != null && value) {
                        newvalues.add(opt.label);
                      } else {
                        newvalues.remove(opt.label);
                      }
                      _onChange(newvalues.join(";"));
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
