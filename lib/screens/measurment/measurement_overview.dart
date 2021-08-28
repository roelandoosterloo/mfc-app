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
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: MeasurementChart(measurements: state.measurements),
                ),
              ),
              Divider(),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: state.measurements.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          f.format(state.measurements[index].date.toLocal()),
                        ),
                        subtitle: Text("Weight: " +
                            state.measurements[index].weight.toString()),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }
        return Text("Loadin");
      },
    );
  }
}
