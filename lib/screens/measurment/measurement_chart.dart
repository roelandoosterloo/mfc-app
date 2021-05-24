// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementChart extends StatelessWidget {
  final List<Measurement> _measurements;

  MeasurementChart({Key? key, required List<Measurement> measurements})
      : _measurements = measurements,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          bottomTitles: SideTitles(
            showTitles: true,
            reservedSize: 22,
            margin: 10,
            getTitles: (value) => value.toString(),
          ),
          leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) => value.toString(),
              margin: 8,
              reservedSize: 30),
        ),
        borderData: FlBorderData(
          show: true,
        ),
        lineBarsData: [
          LineChartBarData(
            // spots: [FlSpot(1, 1), FlSpot(2, 2), FlSpot(3, 3)],
            spots: _measurements
                .map((e) =>
                    FlSpot(e.date.microsecondsSinceEpoch.toDouble(), e.weight))
                .toList(),
            isCurved: true,
            colors: [const Color(0xff2b8474)],
            barWidth: 8,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
          )
        ],
      ),
    );
  }

  // final f = new DateFormat('yyyy-MM-dd');

  // @override
  // Widget build(BuildContext context) {
  //   List<charts.Series<Measurement, DateTime>> series = [
  //     charts.Series<Measurement, DateTime>(
  //       id: 'Weight',
  //       domainFn: (measurement, index) => measurement.date,
  //       measureFn: (measurement, _) => measurement.weight,
  //       data: _measurements,
  //     ),
  //     charts.Series<Measurement, DateTime>(
  //       id: 'Hips',
  //       domainFn: (measurement, index) => measurement.date,
  //       measureFn: (measurement, _) => measurement.hips,
  //       data: _measurements,
  //     ),
  //     charts.Series<Measurement, DateTime>(
  //       id: 'Waist',
  //       domainFn: (measurement, index) => measurement.date,
  //       measureFn: (measurement, _) => measurement.waist,
  //       data: _measurements,
  //     ),
  //   ];

  //   return charts.TimeSeriesChart(
  //     series,
  //     animate: true,
  //     dateTimeFactory: charts.LocalDateTimeFactory(),
  //   );
  // }
}
