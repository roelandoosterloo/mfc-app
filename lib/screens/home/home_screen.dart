import 'dart:async';

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

  bool courseCanBeOpened(
    Course selected,
    Enrollment? currentEnrollment,
    String? loadingCourse,
  ) {
    if (loadingCourse != null) return false;
    if (currentEnrollment == null) return true;
    if (currentEnrollment.isCourseDone()) return true;
    if (selected.id == currentEnrollment.course.id) return true;

    return false;
  }

  void onTap(Course course) {
    HomePageBloc bloc = BlocProvider.of<HomePageBloc>(context);
    if (bloc.state is HomePageLoaded) {
      HomePageLoaded st = bloc.state as HomePageLoaded;
      if (st.loadingCourse != null) return;
      if (st.currentEnrollment == null ||
          st.currentEnrollment!.isCourseDone() ||
          st.currentEnrollment!.course.id == course.id ||
          st.isCourseDone(course.id))
        return BlocProvider.of<HomePageBloc>(context)
            .add(CourseSelected(course.id));

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              "Rond eerst \"${st.currentEnrollment!.course.name}\" af om verder te gaan.",
            ),
          ),
        );
    }
  }

  CourseState courseState(Course course) {
    HomePageBloc bloc = BlocProvider.of<HomePageBloc>(context);
    if (bloc.state is HomePageLoaded) {
      HomePageLoaded st = bloc.state as HomePageLoaded;
      if (st.currentEnrollment != null &&
          course != st.currentEnrollment!.course &&
          !st.currentEnrollment!.isCourseDone()) {
        return CourseState.locked;
      } else {
        return CourseState.availble;
      }
    }
    return CourseState.locked;
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
                    padding: const EdgeInsets.only(
                      bottom: 8.0,
                      top: 8.0,
                    ),
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: BlocListener<HomePageBloc, HomePageState>(
            listener: (context, state) {
              if (state is HomePageError) {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(state.error)));
              }
            },
            child: BlocBuilder<HomePageBloc, HomePageState>(
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
                            highlightCourse: state.currentEnrollment?.course,
                            loading: state.loadingCourse ==
                                state.currentEnrollment?.course.id,
                          ),
                          ...(state.courses.isNotEmpty ||
                                  state.completedCourses.isNotEmpty
                              ? [
                                  SubHeader("Beschikbaar"),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: state.courses
                                          .map((course) => CourseCard(
                                                course: course,
                                                courseState:
                                                    courseState(course),
                                                onTap: () => onTap(course),
                                                isLoading:
                                                    state.loadingCourse !=
                                                            null &&
                                                        state.loadingCourse ==
                                                            course.id,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                  SubHeader("Eerder afgerond"),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: state.completedCourses
                                          .map((course) => CourseCard(
                                                course: course,
                                                courseState: CourseState.done,
                                                onTap: () => onTap(course),
                                                isLoading:
                                                    state.loadingCourse !=
                                                            null &&
                                                        state.loadingCourse ==
                                                            course.id,
                                              ))
                                          .toList(),
                                    ),
                                  ),
                                ]
                              : [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.only(top: 140),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Text(
                                            "Je hebt nog geen programma's. Klik hieronder om de programma's te bekijken. Heb je al wel een programma gekocht en kan je deze niet zien, neem dan even contact op met info@myfoodcoach.nl",
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () => _navBloc
                                              .add(NavigatedToPrograms()),
                                          child: Text("BEKIJK PROGRAMMA'S"),
                                        ),
                                        if (!state
                                            .profile.isProfileComplete) ...[
                                          Text("Of"),
                                          ElevatedButton(
                                            onPressed: () => _navBloc
                                                .add(NavigatedToProfile()),
                                            child: Text(
                                                "MAAK JE PROFIEL COMPLEET"),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ]),
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
