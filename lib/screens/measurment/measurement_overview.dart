import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/constants/values.dart';
import 'package:mfc_app/screens/measurment/measurement_chart2.dart';
import 'package:mfc_app/screens/measurment/measurement_list.dart';
import 'package:mfc_app/screens/measurment/statistic_card.dart';
import 'package:mfc_app/utils/formatter.dart';

part 'measurement_statistics.dart';

class MeasurementOverview extends StatefulWidget {
  @override
  State<MeasurementOverview> createState() => _MeasurementOverviewState();
}

class _MeasurementOverviewState extends State<MeasurementOverview>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementBloc, MeasurementState>(
      builder: (context, state) {
        if (state is NoMeasurementsAvailable) {
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: min(MediaQuery.of(context).size.width,
                          MediaQuery.of(context).size.height) *
                      0.7,
                  child: Image.asset(
                    "assets/images/scale.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  "Geen metingen beschikbaar",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          );
        } else if (state is MeasurementsAvailable) {
          return Container(
            child: SafeArea(
              child: Column(
                children: [
                  Card(
                    color: Theme.of(context).primaryColor,
                    margin: EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: state.measurements.isEmpty
                          ? AspectRatio(
                              aspectRatio: 1.7,
                              child: Placeholder(),
                            )
                          : MeasurementChart2(
                              measurements: state.measurements,
                              profile: state.profile,
                            ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        MeasurementStatistics(
                          currentWeight: state.currentWeight,
                          targetWeight: state.profile.targetWeight,
                          totalWeightLost: state.totalWeightLost,
                        ),
                        MeasurementList(
                          measurements: state.measurements,
                          onDelete: (String id) =>
                              BlocProvider.of<MeasurementBloc>(context).add(
                            new MeasurementDeleteClicked(id),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabPageSelector(
                    controller: tabController,
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
