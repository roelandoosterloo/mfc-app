import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/screens/register/bloc/register_bloc.dart';

class ConfirmCodeForm extends StatefulWidget {
  const ConfirmCodeForm({Key? key}) : super(key: key);

  @override
  State<ConfirmCodeForm> createState() => _ConfirmCodeFormState();
}

class _ConfirmCodeFormState extends State<ConfirmCodeForm> {
  final TextEditingController _confirmCodeController = TextEditingController();
  late RegisterBloc _registerBloc;

  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _confirmCodeController.addListener(_onCodeChange);
  }

  _onCodeChange() {}

  _onSubmitVerification() {
    _registerBloc.add(ConfirmCodeSubmitted(_confirmCodeController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is ConfirmRegistration) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    "Bevestig je registratie".toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Stratum",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _confirmCodeController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.numbers),
                      labelText: "Bevestigingscode",
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: _onSubmitVerification,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text("BEVESTIG"),
                    ),
                  ),
                ],
              ));
        }
        return Container();
      },
    );
  }
}
