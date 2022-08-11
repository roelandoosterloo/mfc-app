part of 'module_single_screen.dart';

class ModuleQuestionsTab extends StatefulWidget {
  ModuleQuestionsTab({
    Key? key,
    required this.progress,
  })  : controller = PageController(initialPage: 0),
        questions = progress.module!.assignments ?? [],
        answers = progress.workbook ?? [],
        super(key: key);

  final PageController controller;
  final ModuleProgress progress;
  final List<Question> questions;
  final List<Answer> answers;

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

  Answer? answer(int page) {
    try {
      return widget.answers.firstWhere(
        (element) => element.questionId == widget.questions[page].id,
        orElse: null,
      );
    } catch (ex) {
      Sentry.captureException(ex);
    }
    return null;
  }

  String? value(int page) {
    if (_answers[page] != null) {
      return _answers[page]!;
    }
    if (answer(page) != null) {
      return answer(page)!.answer;
    }
    return null;
  }

  void submitAnswer() {
    if (_answers[_page] == null) {
      return;
    }
    Question q = widget.questions[_page];
    String value = _answers[_page]!;
    BlocProvider.of<ModuleProgressBloc>(context).add(AnswerGiven(
      q,
      widget.progress,
      answer(_page),
      value,
    ));
  }

  void onChangeAnswer(String value) {
    setState(() {
      _answers[_page] = value;
    });
  }

  void _onCompleteModule() {
    submitAnswer();
    BlocProvider.of<ModuleProgressBloc>(context)
        .add(ModuleCompleted(widget.progress));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: PageView(
            controller: widget.controller,
            scrollDirection: Axis.horizontal,
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
                      value: value(entry.key),
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
                    child: Icon(Icons.chevron_left),
                  ),
                if (_page == 0) Spacer(),
                if (hasMoreQuestions)
                  ElevatedButton(
                    onPressed: () => nextQuestion(context),
                    child: Icon(Icons.chevron_right),
                  ),
                if (!hasMoreQuestions)
                  ElevatedButton(
                    onPressed: _onCompleteModule, //redirect to module overzicht
                    child: Icon(
                      Icons.check,
                    ),
                  ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
