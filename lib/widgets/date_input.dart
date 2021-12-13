import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInput extends StatelessWidget {
  final f = new DateFormat('yyyy-MM-dd');
  final TextEditingController _controller;
  final Function(DateTime)? _onDateSelected;
  final String _labelText;
  final DateTime? _firstDate;
  final DateTime? _lastDate;
  final DateTime? _initialDate;

  DateInput({
    Key? key,
    TextEditingController? controller,
    Function(DateTime)? onDateSelected,
    required String labelText,
    DateTime? firstDate,
    DateTime? lastDate,
    DateTime? initialDate,
  })  : _controller = controller ?? TextEditingController(),
        _onDateSelected = onDateSelected,
        _labelText = labelText,
        _firstDate = firstDate,
        _lastDate = lastDate,
        _initialDate = initialDate,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _controller,
            enabled: false,
            decoration: InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: _labelText,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () => showDatePicker(
            context: context,
            firstDate: _firstDate ?? DateTime.now(),
            lastDate: _lastDate ?? DateTime.now(),
            initialDate: _initialDate ?? DateTime.now(),
          ).then((value) {
            if (value != null) {
              _controller.text = f.format(value);
              if (_onDateSelected != null) {
                _onDateSelected!(value);
              }
            }
          }),
          child: Text("Select date"),
        ),
      ],
    );
  }
}
