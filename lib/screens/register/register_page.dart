import 'package:flutter/material.dart';
import 'package:mfc_app/screens/register/register_screen.dart';

class RegisterPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => RegisterScreen(),
    );
  }
}
