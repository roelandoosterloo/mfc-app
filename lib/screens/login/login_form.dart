import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/login/login_bloc.dart';
import 'package:mfc_app/blocs/login/login_event.dart';
import 'package:mfc_app/blocs/login/login_state.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late LoginBloc _loginBloc;
  late NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _navigationBloc = BlocProvider.of<NavigationBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool canSubmit(LoggingIn state) {
    return state.isEmailValid &&
        state.isPasswordValid &&
        isPopulated &&
        !state.isLoading;
  }

  _onLogin() {
    _loginBloc.add(LoginWithCredentialsSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }

  _onRegister() {
    _navigationBloc.add(NavigatedToRegister());
  }

  _onPasswordReset() {
    _navigationBloc.add(NavigatedToResetPassword());
  }

  _onEmailChange() {
    _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  }

  _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is SetupPassword) {}
        if (state is LoggingIn) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "WELKOM",
                style: TextStyle(
                  fontFamily: 'Stratum',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) =>
                          !state.isEmailValid ? 'Ongeldig email adres' : null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Gebruikersnaam',
                      ),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      autocorrect: false,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) =>
                          !state.isPasswordValid ? 'Ongeldig wachtwoord' : null,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Wachtwoord',
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: canSubmit(state) ? _onLogin : null,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (state.isLoading)
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  height: 20,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                            Text("LOG IN"),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _onPasswordReset,
                      child: Text(
                        "Wachtwoord vergeten?",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
