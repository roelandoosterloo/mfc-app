import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/constants/values.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/measurment/measurement_chart2.dart';
import 'package:mfc_app/screens/measurment/statistic_cart.dart';

class MeasurementOverview extends StatefulWidget {
  @override
  State<MeasurementOverview> createState() => _MeasurementOverviewState();
}

class _MeasurementOverviewState extends State<MeasurementOverview> {
  final f = new DateFormat(DATE_FORMAT);
  Profile? profile;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() {
    context.read<UserRepository>().getUser().then((AuthUser user) {
      context
          .read<ProfileRepository>()
          .getProfile(user.username)
          .then((Profile p) {
        setState(() {
          profile = p;
        });
      });
    });
  }

  double? bmi(double weight) {
    if (profile == null || profile!.length == null) return null;
    double height = profile!.length!;
    return weight / height / height;
  }

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
                        child: profile == null
                            ? AspectRatio(
                                aspectRatio: 1.7,
                                child: Placeholder(),
                              )
                            : MeasurementChart2(
                                measurements: state.measurements,
                                profile: profile,
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
                          subText:
                              "${state.measurements.last.weight.toStringAsFixed(1)} kg",
                          icon: Icons.monitor_weight_outlined,
                          iconColor: Colors.white,
                        ),
                        StatisticCard(
                          title: "Streefgewicht",
                          subText: "${profile?.targetWeight} kg",
                          icon: Icons.flag_outlined,
                          iconColor: Colors.white,
                        ),
                        StatisticCard(
                          title: "Totaal afgevallen",
                          mainText:
                              "${(state.measurements.first.weight - state.measurements.last.weight).toStringAsFixed(1)} ",
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
