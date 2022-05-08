import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/screens/course/single/bloc/singlecoursepage_bloc.dart';

import 'course_single_screen.dart';

class CourseSinglePage extends Page {
  final String _courseId;

  CourseSinglePage(this._courseId) : super(name: "CourseSinglePage");

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => SingleCoursePageBloc(
          _courseId,
          courseRepository: context.read<CourseRepository>(),
          navigationBloc: BlocProvider.of<NavigationBloc>(context),
        ),
        child: CourseSingleScreen(),
      ),
    );
  }
}
