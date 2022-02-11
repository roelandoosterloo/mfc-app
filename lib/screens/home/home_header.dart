part of 'home_screen.dart';

class HomeHeader extends StatelessWidget {
  final String firstName;
  final Course? highlightCourse;
  final bool loading;

  const HomeHeader({
    Key? key,
    required this.firstName,
    this.highlightCourse,
    this.loading = false,
  }) : super(key: key);

  String greeting() {
    int hour = DateTime.now().hour;
    if (hour >= 6 && hour < 12) {
      return "Goedemorgen, $firstName!";
    } else if (hour < 17) {
      return "Goedemiddag, $firstName!";
    } else if (hour < 23) {
      return "Goedenavond, $firstName!";
    }
    return "Hallo, $firstName!";
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
              greeting(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            if (highlightCourse != null)
              CourseCard(
                course: highlightCourse!,
                courseState: CourseState.availble,
                isLoading: loading,
                onTap: () {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(CourseSelected(highlightCourse!.id));
                },
              ),
          ],
        ),
      ],
    );
  }
}
