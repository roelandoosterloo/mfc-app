import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/screens/password_reset/bloc/password_reset_bloc.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key? key}) : super(key: key);

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordRepeatController =
      TextEditingController();

  late PasswordResetBloc _passwordResetBloc;

  @override
  void initState() {
    _emailController.addListener(_onEmailChange);
    _codeController.addListener(_onCodeChange);
    _passwordController.addListener(_onPasswordChange);
    _passwordRepeatController.addListener(_onPasswordRepeatChange);
    _passwordResetBloc = BlocProvider.of<PasswordResetBloc>(context);
    super.initState();
  }

  void _onEmailChange() {
    _passwordResetBloc.add(EmailChanged(email: _emailController.text));
  }

  void _onCodeChange() {
    _passwordResetBloc.add(CodeChanged(code: _codeController.text));
  }

  void _onPasswordChange() {
    _passwordResetBloc.add(PasswordChanged(password: _passwordController.text));
  }

  void _onPasswordRepeatChange() {}

  void _onSubmitCodeRequest() {
    _passwordResetBloc.add(RequestSubmitted(email: _emailController.text));
  }

  void _onSubmitResetPassword() {
    _passwordResetBloc.add(
      ResetConfirmed(
        _codeController.text,
        _passwordController.text,
      ),
    );
  }

  @override
  dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _passwordRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Wachtwoord herstellen"),
      ),
      extendBodyBehindAppBar: true,
      body: BlocConsumer<PasswordResetBloc, PasswordResetState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is PasswordResetInitial) {
            return Container();
          }
          if (state is PasswordResetEmailStep) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) =>
                        !state.emailValid ? "Email adres ongeldig" : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: "Email adres",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.emailValid ? _onSubmitCodeRequest : null,
                    child: Text("HERSTEL"),
                  ),
                ],
              ),
            );
          }
          if (state is PasswordResetCodeStep) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _codeController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) =>
                        !state.isCodeValid ? "Code ongeldig" : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: "Verificatie code",
                    ),
                  ),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (_) =>
                        !state.isPasswordValid ? "Wachtwoord ongeldig" : null,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Nieuw wachtwoord",
                    ),
                  ),
                  TextFormField(
                    controller: _passwordRepeatController,
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: true,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      labelText: "Herhaal wachtwoord",
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.isValid() ? _onSubmitResetPassword : null,
                    child: Text("WACHTWOORD OPSLAAN"),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
