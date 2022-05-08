import 'package:flutter/material.dart';

import 'init_screen.dart';

class InitPage extends Page {
  InitPage() : super(name: "initPage");
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return InitScreen();
      },
    );
  }
}
