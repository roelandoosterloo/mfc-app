import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/screens/measurment/measurement_overview.dart';

class MeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);

    MeasurementRepository _measurementRepo =
        context.read<MeasurementRepository>();
    MeasurementBloc bloc = MeasurementBloc(measurementRepo: _measurementRepo);
    bloc.add(MeasurementsDataRequested());
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text("Measurements"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<MeasurementBloc>(
        create: (context) => bloc,
        child: MeasurementOverview(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navBloc.add(NavigatedToAddMeasurement()),
        child: Icon(Icons.add),
        backgroundColor: Colors.accents.first,
      ),
    );
  }
}
