import 'package:flutter/material.dart';
import 'package:mfc_app/models/Measurement.dart';
import 'package:mfc_app/utils/formatter.dart';

class MeasurementList extends StatelessWidget {
  final List<Measurement> _measurements;
  final Function _onRemove;
  const MeasurementList({
    Key? key,
    required List<Measurement> measurements,
    required Function onDelete,
  })  : _measurements = measurements,
        _onRemove = onDelete,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _measurements.length,
      itemBuilder: (context, index) {
        Measurement m = _measurements[index];
        return Dismissible(
          direction: DismissDirection.endToStart,
          key: Key(m.id),
          onDismissed: (direction) {
            _onRemove(m.id);
          },
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(Icons.delete),
                )
              ],
            ),
          ),
          child: Card(
            child: ListTile(
              title: Text(Formatter.formatTemporalDate(m.date) ?? "Geen datum"),
              subtitle: m.note != null ? Text(m.note!) : null,
              leading: CircleAvatar(
                  radius: 25,
                  child: Text((Formatter.formatDecimal(m.weight) ?? "-"))),
            ),
          ),
        );
      },
    );
  }
}
