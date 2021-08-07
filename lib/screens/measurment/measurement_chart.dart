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

  final f = new DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    List<charts.Series<Measurement, DateTime>> series = [
      charts.Series<Measurement, DateTime>(
        id: 'Weight',
        domainFn: (measurement, index) => measurement.date,
        measureFn: (measurement, _) => measurement.weight,
        data: _measurements,
        colorFn: (datum, index) => charts.Color.fromHex(code: "#2b8474"),
      ),
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: charts.LocalDateTimeFactory(),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }
}
