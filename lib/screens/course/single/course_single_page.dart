import 'package:flutter/material.dart';

import 'course_single_screen.dart';

class CourseSinglePage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => CourseSingleScreen(),
    );
  }
}
