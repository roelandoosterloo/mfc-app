import 'package:flutter/material.dart';
import 'package:mfc_app/screens/landing/landing_screen.dart';

class LandingPage extends Page {
  LandingPage() : super(name: "CourseListPage");
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return LandingScreen();
      },
    );
  }
}
