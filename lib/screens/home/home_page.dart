import 'package:flutter/material.dart';
import 'package:mfc_app/screens/home/home_screen.dart';

class HomePage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return HomeScreen();
      },
    );
  }
}
