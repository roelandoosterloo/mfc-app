import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/add_measurement/add_measurement_bloc.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_form.dart';

class AddMeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MeasurementRepository _measureRepo = context.read<MeasurementRepository>();
    UserRepository _userRepo = context.read<UserRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Meting toevoegen"),
      ),
      body: BlocProvider<AddMeasurementBloc>(
        create: (context) => AddMeasurementBloc(
          measureRepo: _measureRepo,
          userRepo: _userRepo,
        ),
        child: SingleChildScrollView(child: AddMeasurementForm()),
      ),
    );
  }
}
