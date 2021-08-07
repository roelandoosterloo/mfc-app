import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/add_measurement/add_measurement_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/utils/input_formatter.dart';

class AddMeasurementForm extends StatefulWidget {
  @override
  _AddMeasurementFormState createState() => _AddMeasurementFormState();
}

class _AddMeasurementFormState extends State<AddMeasurementForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _hipsController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late AddMeasurementBloc _measurementBloc;
  final f = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _measurementBloc = BlocProvider.of<AddMeasurementBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _weightController.dispose();
    _hipsController.dispose();
    _waistController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddMeasurementBloc, AddMeasurementState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state.error != null)
                      Flexible(
                        child: Text(
                          state.error!,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    else
                      Text(
                        "Could not add measurement",
                        style: TextStyle(color: Colors.white),
                      ),
                    Icon(Icons.error, color: Colors.white),
                  ],
                ),
              ),
            );
        }
        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Saving..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<NavigationBloc>(context).add(
            NavigatedToMeasurements(),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _dateController,
                      enabled: false,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Measurement date",
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => showDatePicker(
                      context: context,
                      firstDate: DateTime.parse("2020-01-01"),
                      lastDate: DateTime.now(),
                      initialDate: DateTime.now(),
                    ).then((value) {
                      if (value != null) {
                        _dateController.text = f.format(value);
                        _measurementBloc.add(
                          MeasurementDateChanged(date: value),
                        );
                      }
                    }),
                    child: Text("Select date"),
                  ),
                ],
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) =>
                    !state.isWeightValid ? 'Invalid weight number' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.fitness_center),
                  suffix: Text("kg"),
                  labelText: "Weight",
                ),
                inputFormatters: [
                  buildDecimalFormatter(precision: 2),
                ],
              ),
              TextFormField(
                controller: _waistController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) =>
                    !state.isWaistValid ? 'Invalid waist circumference' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.straighten),
                  suffix: Text("cm"),
                  labelText: "Waist circumference",
                ),
                inputFormatters: [
                  buildDecimalFormatter(precision: 1),
                ],
              ),
              TextFormField(
                controller: _hipsController,
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) =>
                    !state.isHipsValid ? 'Invalid hips circumference' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.straighten),
                  suffix: Text("cm"),
                  labelText: "Hip circumference",
                ),
                inputFormatters: [
                  buildDecimalFormatter(precision: 1),
                ],
              ),
              TextFormField(
                controller: _noteController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) => !state.isNoteValid ? 'Invalid note' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.sticky_note_2),
                  labelText: "Notes",
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: () => {
                    BlocProvider.of<AddMeasurementBloc>(context).add(
                      MeasurementSubmitted(
                        date: DateTime.now(),
                        weight: double.parse(_weightController.text),
                        hips: double.parse(_hipsController.text),
                        waist: double.parse(_waistController.text),
                        note: _noteController.text,
                      ),
                    ),
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
