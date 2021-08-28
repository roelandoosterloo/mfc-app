import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/add_measurement/add_measurement_bloc.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_form.dart';

class AddMeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MeasurementRepository _measureRepo = context.read<MeasurementRepository>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Add measurement"),
      ),
      body: BlocProvider<AddMeasurementBloc>(
        create: (context) => AddMeasurementBloc(measureRepo: _measureRepo),
        child: AddMeasurementForm(),
      ),
    );
  }
}
