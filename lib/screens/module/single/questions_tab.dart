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

  void nextQuestion(BuildContext context) {
    FocusScope.of(context).unfocus();
    widget.controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void previousQuestion(BuildContext context) {
    FocusScope.of(context).unfocus();
    widget.controller.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  bool get hasMoreQuestions {
    return _page < widget.questions.length - 1;
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
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        Divider(),
        Padding(
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
        )
      ],
    );
  }
}
