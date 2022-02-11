import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/measurment/measurement_overview.dart';
import 'package:mfc_app/screens/measurment/measurement_page.dart';

class MeasurementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);

    MeasurementRepository _measurementRepo =
        context.read<MeasurementRepository>();
    MeasurementBloc bloc = MeasurementBloc(
      measurementRepo: _measurementRepo,
      userRepo: context.read<UserRepository>(),
      profileRepo: context.read<ProfileRepository>(),
    );
    bloc.add(MeasurementsDataRequested());

    return Scaffold(
      appBar: AppBar(
        title: Text("Mijn metingen"),
      ),
      body: BlocProvider<MeasurementBloc>(
        create: (context) => bloc,
        child: BlocListener<NavigationBloc, NavigationState>(
          listener: (context, state) {
            if (state.wentBack && state.stack.peek() is MeasurementPage) {
              print("refresh");
              BlocProvider.of<MeasurementBloc>(context)
                  .add(MeasurementsDataRequested());
            }
          },
          child: MeasurementOverview(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navBloc.add(NavigatedToAddMeasurement()),
        child: Icon(Icons.add),
      ),
    );
  }
}
