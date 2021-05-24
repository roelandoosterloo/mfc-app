import 'package:flutter/material.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_screen.dart';

class AddMeasurementPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => AddMeasurementScreen(),
    );
  }
}
