// ignore: import_of_legacy_library_into_null_safe
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/constants/values.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/models/measurement.dart';

class MeasurementChart2 extends StatefulWidget {
  final List<Measurement> _measurements;
  final Profile? _profile;

  MeasurementChart2(
      {Key? key, required List<Measurement> measurements, Profile? profile})
      : _measurements = measurements,
        _profile = profile,
        super(key: key);

  @override
  State<MeasurementChart2> createState() => _MeasurementChart2State();
}

class _MeasurementChart2State extends State<MeasurementChart2> {
  final f = new DateFormat(DATE_FORMAT);
  final int _leftLabelCount = 6;
  final int _bottomLabelCount = 4;
  List<FlSpot> _values = const [];
  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;
  double _leftTitlesInterval = 2;

  @override
  void initState() {
    super.initState();
    _prepareData();
  }

  void _prepareData() {
    widget._measurements.sort((m1, m2) => m1.date.compareTo(m2.date));
    _values = widget._measurements
        .map((e) => FlSpot(e.date.millisecondsSinceEpoch.toDouble(), e.weight))
        .toList();

    _maxX = _values
        .map((e) => e.x)
        .reduce((value, element) => value > element ? value : element);
    _minX = _values
        .map((e) => e.x)
        .reduce((value, element) => value < element ? value : element);
    _maxY = _values
        .map((e) => e.y)
        .reduce((value, element) => value > element ? value : element);
    _minY = _values
        .map((e) => e.y)
        .reduce((value, element) => value < element ? value : element);

    _maxY = max(_maxY, widget._profile?.targetWeight ?? 0);
    _minY = min(_minY, widget._profile?.targetWeight ?? double.infinity);

    _leftTitlesInterval =
        max(5, ((_maxY - _minY) / (_leftLabelCount - 2)).ceilToDouble());

    _minY = (_minY / _leftTitlesInterval).floorToDouble() * _leftTitlesInterval;
    _maxY = (_maxY / _leftTitlesInterval).ceilToDouble() * _leftTitlesInterval;
  }

  double? bmiWeight(double bmiTarget) {
    if (widget._profile != null && widget._profile!.length == null) return null;
    double height = widget._profile!.length!;
    return bmiTarget * height * height;
  }

  LineChartBarData _lineBarData() {
    return LineChartBarData(
      spots: _values,
      barWidth: 3,
      dotData: FlDotData(show: widget._measurements.length <= 1),
      isCurved: true,
      curveSmoothness: 0.2,
      colors: [
        Color(0xfff44336),
      ],
    );
  }

  LineChartBarData _targetLine() {
    return LineChartBarData(
      spots: _values
          .map((spot) => FlSpot(spot.x, widget._profile!.targetWeight!))
          .toList(),
      barWidth: 2,
      dotData: FlDotData(show: false),
      colors: [Colors.white],
    );
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      getTitles: (value) {
        final DateTime date =
            DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return "${DateFormat.MMM().format(date)}\n${DateFormat.d().format(date)}";
      },
      margin: 8,
      interval: max(1000 * 60 * 60 * 24, (_maxX - _minX) / _bottomLabelCount),
      getTextStyles: (context, value) => TextStyle(color: Colors.white54),
    );
  }

  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      reservedSize: 28,
      margin: 12,
      interval: _leftTitlesInterval,
      getTextStyles: (context, value) => TextStyle(color: Colors.white54),
    );
  }

  FlGridData _gridData() {
    return FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: _leftTitlesInterval,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: Theme.of(context).primaryColorLight,
          strokeWidth: 1,
        );
      },
    );
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: _gridData(),
      titlesData: FlTitlesData(
        bottomTitles: _bottomTitles(),
        leftTitles: _leftTitles(),
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
      ),
      lineBarsData: [_targetLine(), _lineBarData()],
      borderData: FlBorderData(
        border: Border.symmetric(
          vertical: BorderSide.none,
          horizontal: BorderSide(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      minX: _minX,
      maxX: _maxX,
      minY: _minY,
      maxY: _maxY,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 16,
          left: 0,
          top: 24,
          bottom: 12,
        ),
        child: LineChart(_mainData()),
      ),
    );
  }
}
