import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/single/single_course_bloc.dart';
import 'package:mfc_app/repositories/course_repository.dart';

import 'course_single_screen.dart';

class CourseSinglePage extends Page {
  final String _courseId;

  CourseSinglePage({required String courseId}) : _courseId = courseId;

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => SingleCourseBloc(
          courseRepo: context.read<CourseRepository>(),
        ),
        child: CourseSingleScreen(courseId: _courseId),
      ),
    );
  }
}
