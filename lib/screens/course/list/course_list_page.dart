import 'package:flutter/material.dart';

import 'course_list_screen.dart';

class CourseListPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => CourseListScreen(),
    );
  }
}
