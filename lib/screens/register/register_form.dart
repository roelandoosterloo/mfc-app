import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/register/register_bloc.dart';
import 'package:mfc_app/blocs/register/register_event.dart';
import 'package:mfc_app/blocs/register/register_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool canSubmit(RegisterState state) {
    return state.isEmailValid &&
        state.isPasswordValid &&
        isPopulated &&
        !state.isSubmitting;
  }

  _onRegister() {
    _registerBloc.add(RegisterWithCredentialsSubmitted(
        email: _emailController.text, password: _passwordController.text));
  }

  _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
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
                        "Registration failed",
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
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) => Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
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
              SizedBox(
                height: 20,
              ),
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
                  onPressed: canSubmit(state) ? _onRegister : null,
                  child: Row(
                    children: [Icon(Icons.check), Text("Register")],
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
