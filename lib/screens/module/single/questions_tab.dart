part of 'module_single_screen.dart';

class ModuleQuestionsTab extends StatefulWidget {
  ModuleQuestionsTab({
    Key? key,
    required this.questions,
  })  : controller = PageController(initialPage: 0),
        super(key: key);

  final PageController controller;
  final List<Question> questions;

  @override
  State<ModuleQuestionsTab> createState() => _ModuleQuestionsTabState();
}

class _ModuleQuestionsTabState extends State<ModuleQuestionsTab> {
  int _page = 0;
  Map<int, String?> _answers = {};

  void nextQuestion(BuildContext context) {
    FocusScope.of(context).unfocus();
    submitAnswer();
    widget.controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void previousQuestion(BuildContext context) {
    FocusScope.of(context).unfocus();
    submitAnswer();
    widget.controller.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  bool get hasMoreQuestions {
    return _page < widget.questions.length - 1;
  }

  String? get answer {
    Question q = widget.questions[_page];
    if (_answers[_page] != null) {
      return _answers[_page]!;
    }
    if (q.answer != null) {
      return q.answer!.answer;
    }
    return null;
  }

  void submitAnswer() {
    if (_answers[_page] == null) {
      return;
    }
    Question q = widget.questions[_page];
    String answer = _answers[_page]!;
    print(q.question);
    print(answer);
    BlocProvider.of<ModuleProgressBloc>(context).add(AnswerGiven(q, answer));
  }

  void onChangeAnswer(String value) {
    setState(() {
      _answers[_page] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            controller: widget.controller,
            scrollDirection: Axis.vertical,
            onPageChanged: (int page) {
              setState(() {
                _page = page;
              });
            },
            children: widget.questions
                .asMap()
                .entries
                .map(
                  (entry) => SingleChildScrollView(
                    child: QuestionW(
                      question: entry.value,
                      index: entry.key + 1,
                      key: Key(entry.value.id),
                      onChange: (value) => onChangeAnswer(value),
                      value: answer,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Divider(),
        Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_page > 0)
                  ElevatedButton(
                    onPressed: () => previousQuestion(context),
                    child: Text("Previous Question"),
                  ),
                if (_page == 0) Spacer(),
                if (hasMoreQuestions)
                  ElevatedButton(
                    onPressed: () => nextQuestion(context),
                    child: Text("Next Question"),
                  ),
                if (!hasMoreQuestions)
                  ElevatedButton(onPressed: () => null, child: Text("Done")),
              ],
            ),
          ),
        )
      ],
    );
  }
}
