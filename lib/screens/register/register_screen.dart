import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/register/register_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/register/register_form.dart';
import 'package:mfc_app/widgets/curved_widget.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = context.read<UserRepository>();
    ThemeData theme = Theme.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepo: _userRepository),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top,
                        ),
                        child: SizedBox(
                          width: 150.0,
                          child: Image.asset(
                            "assets/images/logo.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  child: RegisterForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
