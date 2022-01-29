import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/blocs/add_measurement/add_measurement_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/utils/input_formatter.dart';
import 'package:mfc_app/widgets/date_input.dart';

class AddMeasurementForm extends StatefulWidget {
  @override
  _AddMeasurementFormState createState() => _AddMeasurementFormState();
}

class _AddMeasurementFormState extends State<AddMeasurementForm> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  late AddMeasurementBloc _measurementBloc;
  final f = new DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    _measurementBloc = BlocProvider.of<AddMeasurementBloc>(context);
    _dateController.addListener(_onDateChange);
    _weightController.addListener(_onWeightChange);
    _noteController.addListener(_onNoteChange);
  }

  @override
  void dispose() {
    super.dispose();
    _dateController.dispose();
    _weightController.dispose();
    _noteController.dispose();
  }

  _onDateChange() {
    _measurementBloc.add(MeasurementDateChanged(date: _dateController.text));
  }

  _onWeightChange() {
    _measurementBloc
        .add(MeasurementWeightChanged(weight: _weightController.text));
  }

  _onNoteChange() {
    _measurementBloc.add(MeasurementNoteChanged(note: _noteController.text));
  }

  void submitMeasurement() {
    BlocProvider.of<AddMeasurementBloc>(context).add(
      MeasurementSubmitted(
        date: f.parse(_dateController.text),
        weight: double.parse(_weightController.text),
        note: _noteController.text,
      ),
    );
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
            NavigatedBack(),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              DateInput(
                labelText: "Measurement date",
                firstDate: DateTime.now().subtract(
                  Duration(
                    days: 1000,
                  ),
                ),
                controller: _dateController,
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) =>
                    !state.isWeightValid ? 'Gewicht ongeldig' : null,
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                ),
                onPressed: state.isValid() ? submitMeasurement : null,
                child: Text("Submit"),
              ),
              if (!state.isValid()) Text("Niet alle velden zijn goed ingevuld"),
            ],
          ),
        );
      },
    );
  }
}
