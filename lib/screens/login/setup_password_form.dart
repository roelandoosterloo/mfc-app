import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/login/login_bloc.dart';
import 'package:mfc_app/blocs/login/login_event.dart';
import 'package:mfc_app/blocs/login/login_state.dart';

class SetupPasswordForm extends StatefulWidget {
  const SetupPasswordForm({Key? key}) : super(key: key);

  @override
  State<SetupPasswordForm> createState() => _SetupPasswordFormState();
}

class _SetupPasswordFormState extends State<SetupPasswordForm> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatController = TextEditingController();

  late LoginBloc _loginBloc;

  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _passwordController.addListener(_onNewPWChange);
    _repeatController.addListener(_onRepeatChange);
  }

  void dispose() {
    _passwordController.dispose();
    _repeatController.dispose();
    super.dispose();
  }

  _onNewPWChange() {
    _loginBloc.add(LoginCodeChanged(code: _passwordController.text));
  }

  _onRepeatChange() {
    _loginBloc.add(LoginRepeatChanged(
      password: _passwordController.text,
      repeat: _repeatController.text,
    ));
  }

  _onSubmitVerification() {
    _loginBloc.add(
      LoginConfirmationSubmitted(
        code: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        print("state changed");
        if (state is SetupPassword) {
          print(state.isPasswordValid);
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Stel je wachtwoord in".toUpperCase(),
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: "Stratum",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_) =>
                      !state.isPasswordValid ? 'Ongeldig wachtwoord' : null,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Nieuw wachtwoord",
                  ),
                ),
                TextFormField(
                  controller: _repeatController,
                  keyboardType: TextInputType.text,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (_) =>
                      !state.isRepeatValid ? 'Wachtwoord niet hetzelfde' : null,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    labelText: "Herhaal wachtwoord",
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: _onSubmitVerification,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text("OPSLAAN"),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
