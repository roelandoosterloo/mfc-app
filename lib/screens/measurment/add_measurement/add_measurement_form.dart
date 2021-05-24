import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/add_measurement/add_measurement_bloc.dart';
import 'package:mfc_app/utils/input_formatter.dart';

class AddMeasurementForm extends StatelessWidget {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _hipsController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddMeasurementBloc, AddMeasurementState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
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
                    labelText: "Weight"),
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
                    labelText: "Waist circumference"),
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
                    labelText: "Hip circumference"),
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
                    icon: Icon(Icons.sticky_note_2), labelText: "Notes"),
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
                      child: Text("Submit")))
            ],
          ),
        );
      },
    );
  }
}
