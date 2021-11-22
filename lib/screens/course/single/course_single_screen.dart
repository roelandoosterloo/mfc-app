import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/course/single/single_course_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';
import 'package:mfc_app/widgets/curved_widget.dart';
import 'package:mfc_app/widgets/loading.dart';
import 'package:mfc_app/widgets/s3_image.dart';

part "module_card.dart";

class CourseSingleScreen extends StatefulWidget {
  final String _courseId;

  const CourseSingleScreen({Key? key, required String courseId})
      : _courseId = courseId,
        super(key: key);

  @override
  _CourseSingleScreenState createState() => _CourseSingleScreenState(_courseId);
}

class _CourseSingleScreenState extends State<CourseSingleScreen> {
  final String courseId;

  _CourseSingleScreenState(this.courseId);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SingleCourseBloc>(context).add(CourseSelected(courseId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCourseBloc, SingleCourseState>(
      builder: (context, state) {
        if (state is SingleInitial) {
          return Scaffold(
            body: Container(
              child: Text(
                "Loading...",
              ),
            ),
          );
        } else if (state is CourseNotFound) {
          return Scaffold(
            body: Container(
              child: Text(
                "The selected course does not exist.",
              ),
            ),
          );
        } else if (state is CourseLoading) {
          return Loading();
        } else if (state is CourseAvailable) {
          Enrollment enrollment = state.course;
          Course course = enrollment.course;
          List<ModuleProgress> modules = enrollment.moduleSchedule ?? [];
          modules.sort((a, b) =>
              a.availableAt.millisecondsSinceEpoch -
              b.availableAt.millisecondsSinceEpoch);

          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xff2b8474),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 250,
                    child: S3Image(
                      course.coverImage!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 75, left: 50),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff2b8474).withOpacity(0),
                          Color(0xff2b8474),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 230,
                          width: double.infinity,
                        ),
                        Text(
                          course.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          course.description ?? "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        ...modules.map(
                          (ModuleProgress m) {
                            return ModuleCard(progress: m);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    Text("Weird..."),
                    MaterialButton(
                      onPressed: () =>
                          BlocProvider.of<SingleCourseBloc>(context)
                              .add(CourseSelected(courseId)),
                      child: Text("reload"),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
