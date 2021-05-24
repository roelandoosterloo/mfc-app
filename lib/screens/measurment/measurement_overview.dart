import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/screens/measurment/measurement_chart.dart';

class MeasurementOverview extends StatelessWidget {
  final f = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementBloc, MeasurementState>(
      builder: (context, state) {
        if (state is MeasurementsAvailable) {
          return Column(
            children: [
              SizedBox(
                height: 150,
                child: MeasurementChart(measurements: state.measurements),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: state.measurements.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      f.format(state.measurements[index].date.toLocal()),
                    ),
                    subtitle: Text("Weight: " +
                        state.measurements[index].weight.toString() +
                        ", Hips: " +
                        state.measurements[index].hips.toString() +
                        ", Waist: " +
                        state.measurements[index].waist.toString()),
                  );
                },
              ),
            ],
          );
        }
        return Text("Loadin");
      },
    );
  }
}
