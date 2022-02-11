import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/screens/home/home_page.dart';
import 'package:mfc_app/widgets/s3_image.dart';

import '../../models/course/Enrollment.dart';
import 'homepage/homepage_bloc.dart';

part 'course_card.dart';
part 'home_header.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomePageBloc>(context).add(HomePageOpened());
  }

  bool courseCanBeOpened(Course selected, Enrollment? currentEnrollment) {
    if (currentEnrollment == null) return true;
    if (currentEnrollment.isCourseDone()) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);
    return BlocListener<NavigationBloc, NavigationState>(
      listener: (context, state) {
        if (state.wentBack && state.stack.peek() is HomePage) {
          BlocProvider.of<HomePageBloc>(context).add(HomePageOpened());
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_down),
              label: "Metingen",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profiel",
            ),
          ],
          onTap: (int index) {
            switch (index) {
              case 0:
                {
                  _navBloc.add(NavigatedToHome());
                }
                break;
              case 1:
                {
                  _navBloc.add(NavigatedToMeasurements());
                }
                break;
              case 2:
                {
                  _navBloc.add(NavigatedToProfile());
                }
            }
          },
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 60,
                floating: true,
                pinned: true,
                flexibleSpace: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoaded) {
                return Container(
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HomeHeader(
                          firstName: state.profile.firstName,
                          highlightCourse: state.highlightedCourse,
                          loading: state.loadingCourse,
                        ),
                        SubHeader("Beschikbaar"),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.courses
                                .map((course) => CourseCard(
                                      course: course,
                                      courseState: courseCanBeOpened(course,
                                                  state.currentEnrollment) ||
                                              course.id ==
                                                  state.highlightedCourse?.id
                                          ? CourseState.availble
                                          : CourseState.locked,
                                      onTap: () => courseCanBeOpened(
                                              course, state.currentEnrollment)
                                          ? BlocProvider.of<HomePageBloc>(
                                                  context)
                                              .add(CourseSelected(course.id))
                                          : null,
                                      isLoading: state.loadingCourse,
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

class SubHeader extends StatelessWidget {
  final String header;

  const SubHeader(
    String header, {
    Key? key,
  })  : header = header,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 24,
      ),
      child: Text(
        header.toUpperCase(),
        style: TextStyle(
          fontSize: 20,
          fontFamily: 'Stratum',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
