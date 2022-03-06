import 'package:flutter/material.dart';
import 'package:mfc_app/models/measurement.dart';
import 'package:mfc_app/utils/formatter.dart';

class MeasurementList extends StatelessWidget {
  final List<Measurement> _measurements;
  const MeasurementList({Key? key, required List<Measurement> measurements})
      : _measurements = measurements,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _measurements.length,
      itemBuilder: (context, index) {
        Measurement m = _measurements[index];
        return Card(
          child: ListTile(
            title: Text(Formatter.formatDate(m.date) ?? "Geen datum"),
            subtitle: m.note != null ? Text(m.note!) : null,
            leading: CircleAvatar(
                child: Text((Formatter.formatDecimal(m.weight) ?? "-"))),
          ),
        );
      },
    );
  }
}
