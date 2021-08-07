import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
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

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool canSubmit(LoginState state) {
    return state.isEmailValid &&
        state.isPasswordValid &&
        isPopulated &&
        !state.isSubmitting;
  }

  _onLogin() {
    _loginBloc.add(LoginWithCredentialsSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }

  _onRegister() {
    _navigationBloc.add(NavigatedToRegister());
  }

  _onEmailChange() {
    _loginBloc.add(LoginEmailChanged(email: _emailController.text));
  }

  _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (state.error.isNotEmpty)
                      Flexible(
                        child: Text(
                          state.error,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    else
                      Text(
                        "Login failed",
                        style: TextStyle(color: Colors.white),
                      ),
                    Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                  ],
                ),
                backgroundColor: Colors.red[400],
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
                    Text("Loading..."),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(
            AuthenticationLoggedIn(),
          );
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) => !state.isEmailValid ? 'Invalid email' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: 'Email',
                ),
              ),
              TextFormField(
                controller: _passwordController,
                autocorrect: false,
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (_) =>
                    !state.isPasswordValid ? 'Invalid password' : null,
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: canSubmit(state) ? _onLogin : null,
                  child: Row(
                    children: [Icon(Icons.check), Text("Login")],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 130,
                child: ElevatedButton(
                  onPressed: _onRegister,
                  child: Row(
                    children: [Icon(Icons.add), Text("Register")],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
