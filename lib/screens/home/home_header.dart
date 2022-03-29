part of 'home_screen.dart';

class HomeHeader extends StatefulWidget {
  final String firstName;
  final Course? highlightCourse;
  final bool loading;

  const HomeHeader({
    Key? key,
    required this.firstName,
    this.highlightCourse,
    this.loading = false,
  }) : super(key: key);

  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  Timer? _timer;
  String greet = "Hi!";

  void initState() {
    super.initState();
    greet = greeting();
    _timer = Timer.periodic(Duration(minutes: 30), (timer) {
      setState(() {
        greet = greeting();
      });
    });
  }

  String greeting() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return "Goedemorgen, ${widget.firstName}!";
    } else if (hour < 17) {
      return "Goedemiddag, ${widget.firstName}!";
    } else if (hour < 23) {
      return "Goedenavond, ${widget.firstName}!";
    }
    return "Hallo, ${widget.firstName}!";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topCenter,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.2,
          color: Theme.of(context).primaryColor,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              greet,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            if (widget.highlightCourse != null)
              CourseCard(
                course: widget.highlightCourse!,
                courseState: CourseState.availble,
                isLoading: widget.loading,
                onTap: () {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(CourseSelected(widget.highlightCourse!.id));
                },
              ),
          ],
        ),
      ],
    );
  }
}
