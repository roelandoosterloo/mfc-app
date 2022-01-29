import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/enrollment/enrollment_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/widgets/s3_image.dart';

part 'course_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EnrollmentBloc>(context).add(EnrolledCoursesRequested());
  }

  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);
    AuthenticationBloc _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
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
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ];
        },
        body: BlocBuilder<EnrollmentBloc, EnrollmentState>(
          builder: (context, state) {
            if (state is EnrollmentState) {
              return Container(
                child: ListView.builder(
                  itemCount: state.enrollments.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Enrollment enrollment = state.enrollments[index];

                    return CourseCard(
                      enrollment: enrollment,
                      onTap: () {
                        BlocProvider.of<EnrollmentBloc>(context)
                            .add(EnrolledCourseSelected(enrollment));
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigatedToCourse(enrollment.id));
                      },
                    );
                  },
                ),
              );
            }
            return Text("Loading");
          },
        ),
      ),
      // body: Stack(
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.25,
      //       width: MediaQuery.of(context).size.width,
      //       color: Color(0xff2b8474),
      //     ),
      //     Container(
      //       padding:
      //           EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.10),
      //       alignment: Alignment.topCenter,
      //       child: Image.asset(
      //         "assets/logo.png",
      //         height: MediaQuery.of(context).size.height * 0.08,
      //         fit: BoxFit.contain,
      //       ),
      //     ),
      //     BlocBuilder<EnrollmentBloc, EnrollmentState>(
      //       builder: (context, state) {
      //         if (state is EnrollmentState) {
      //           return Container(
      //             child: ListView.builder(
      //               itemCount: state.enrollments.length,
      //               scrollDirection: Axis.vertical,
      //               shrinkWrap: true,
      //               itemBuilder: (context, index) {
      //                 Enrollment enrollment = state.enrollments[index];
      //                 Course course = enrollment.course;

      //                 return CourseCard(
      //                   enrollment: enrollment,
      //                   onTap: () {
      //                     BlocProvider.of<EnrollmentBloc>(context)
      //                         .add(EnrolledCourseSelected(enrollment));
      //                     BlocProvider.of<NavigationBloc>(context)
      //                         .add(NavigatedToCourse(enrollment.id));
      //                   },
      //                 );
      //               },
      //             ),
      //           );
      //         }
      //         return Text("Loading");
      //       },
      //     )
      //   ],
      // ),
    );
  }
}
