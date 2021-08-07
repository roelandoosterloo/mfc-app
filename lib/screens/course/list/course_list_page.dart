import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/list/course_list_bloc.dart';
import 'package:mfc_app/repositories/course_repository.dart';

import 'course_list_screen.dart';

class CourseListPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => CourseListBloc(
          courseRepo: context.read<CourseRepository>(),
        ),
        child: CourseListScreen(),
      ),
    );
  }
}
