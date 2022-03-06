// ignore: import_of_legacy_library_into_null_safe
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementChart extends StatelessWidget {
  final List<Measurement> _measurements;
  final Profile? _profile;

  MeasurementChart(
      {Key? key, required List<Measurement> measurements, Profile? profile})
      : _measurements = measurements,
        _profile = profile,
        super(key: key);

  double? bmiWeight(double bmiTarget) {
    if (_profile != null && _profile!.length == null) return null;
    double height = _profile!.length!;
    return bmiTarget * height * height;
  }

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
      if (_profile?.targetWeight != null)
        charts.Series<Measurement, DateTime>(
          id: 'Target',
          domainFn: (measurement, index) => measurement.date,
          measureFn: (_, _2) => _profile!.targetWeight,
          data: _measurements,
        )
    ];

    return charts.TimeSeriesChart(
      series,
      animate: true,
      dateTimeFactory: charts.LocalDateTimeFactory(),
      behaviors: [
        new charts.RangeAnnotation(
          [
            if (_profile?.length != null)
              new charts.RangeAnnotationSegment(
                bmiWeight(18.5)!,
                bmiWeight(25)!,
                charts.RangeAnnotationAxisType.measure,
                color: charts.MaterialPalette.green.shadeDefault,
                startLabel: "Gezond BMI",
              ),
            if (_profile?.length != null)
              new charts.RangeAnnotationSegment(
                bmiWeight(25)!,
                bmiWeight(30)!,
                charts.RangeAnnotationAxisType.measure,
                color: charts.MaterialPalette.deepOrange.shadeDefault,
                startLabel: "Overgewicht",
              ),
          ],
        ),
      ],
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(zeroBound: false),
      ),
    );
  }
}
