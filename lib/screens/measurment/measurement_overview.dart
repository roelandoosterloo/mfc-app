import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/constants/values.dart';
import 'package:mfc_app/screens/measurment/measurement_chart2.dart';
import 'package:mfc_app/screens/measurment/statistic_card.dart';

class MeasurementOverview extends StatelessWidget {
  final f = new DateFormat.yMd(Intl.getCurrentLocale());
  final n = new NumberFormat(SINGLE_DECIMAL_FORMAT);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MeasurementBloc, MeasurementState>(
      builder: (context, state) {
        if (state is MeasurementsAvailable) {
          return Container(
            child: SafeArea(
              child: SingleChildScrollView(
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
                    GridView.count(
                      primary: false,
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      children: [
                        StatisticCard(
                          title: "Huidige gewicht",
                          subText: state.currentWeight != null
                              ? "${n.format(state.currentWeight!)} kg"
                              : "Niet beschikbaar",
                          icon: Icons.monitor_weight_outlined,
                          iconColor: Colors.white,
                        ),
                        StatisticCard(
                          title: "Streefgewicht",
                          subText:
                              "${state.profile.targetWeight != null ? n.format(state.profile.targetWeight) : "-"} kg",
                          icon: Icons.flag_outlined,
                          iconColor: Colors.white,
                        ),
                        StatisticCard(
                          title: "Totaal afgevallen",
                          mainText: state.totalWeightLost != null
                              ? n.format(state.totalWeightLost)
                              : "-",
                          subText: "kg",
                          iconColor: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
