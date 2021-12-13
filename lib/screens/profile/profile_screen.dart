import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/profile/profile_bloc.dart';
import 'package:mfc_app/widgets/date_input.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();

  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _firstNameController.addListener(_onFirstNameChange);
    _lastNameController.addListener(_onLastNameChange);
    _birthDateController.addListener(_onBirthdateChange);
    _lengthController.addListener(_onLengthChange);
    _targetWeightController.addListener(_onTargetWeightChange);
  }

  _onFirstNameChange() {
    _profileBloc.add(FirstNameChanged(name: _firstNameController.text));
  }

  _onLastNameChange() {
    _profileBloc.add(LastNameChanged(name: _lastNameController.text));
  }

  _onBirthdateChange() {
    _profileBloc
        .add(BirthdateChanged(date: DateTime.parse(_birthDateController.text)));
  }

  _onLengthChange() {
    _profileBloc
        .add(LengthChanged(length: double.parse(_lengthController.text)));
  }

  _onTargetWeightChange() {
    _profileBloc.add(TargetWeightChanged(
        weight: double.parse(_targetWeightController.text)));
  }

  _onSubmit() {
    _profileBloc.add(
      ProfileSubmitted(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        birthDate: DateTime.parse(_birthDateController.text),
        length: double.parse(_lengthController.text),
        weight: double.parse(_targetWeightController.text),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _lengthController.dispose();
    _targetWeightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) => {},
        builder: (context, state) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => !state.isFirstNameValid
                        ? 'Voornaam is niet geldig'
                        : null,
                    keyboardType: TextInputType.name,
                    controller: _firstNameController,
                    decoration: InputDecoration(labelText: "Voornaam"),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => !state.isLastNameValid
                        ? 'Achternaam niet geldig'
                        : null,
                    keyboardType: TextInputType.name,
                    controller: _lastNameController,
                    decoration: InputDecoration(labelText: "Achternaam"),
                  ),
                  DateInput(
                    labelText: "Date of birth",
                    controller: _birthDateController,
                    onDateSelected: (p0) => null,
                    firstDate: DateTime.parse("1950-01-01"),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => !state.isLengthValid
                        ? 'Ingevulde lengte ongeldig'
                        : null,
                    keyboardType: TextInputType.number,
                    controller: _lengthController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Lengte",
                      suffix: Text("m"),
                    ),
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) => !state.isWeightValid
                        ? 'Ingevulde gewicht ongeldig'
                        : null,
                    keyboardType: TextInputType.number,
                    controller: _targetWeightController,
                    autocorrect: false,
                    decoration: InputDecoration(
                      labelText: "Streefgewicht",
                      suffix: Text("kg"),
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      onPressed: _onSubmit,
                      child: Text("Submit"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
