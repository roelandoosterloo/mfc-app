import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/login/login_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/login/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = context.read<UserRepository>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(
          userRepo: _userRepository,
          authBloc: context.read<AuthenticationBloc>(),
        ),
        child: Container(
          child: Column(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 150.0,
                      child: Image.asset(
                        "assets/images/logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "WELKOM",
                style: TextStyle(
                  fontFamily: 'Stratum',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Spacer(
                flex: 1,
              ),
              LoginForm(),
              if (MediaQuery.of(context).viewInsets.bottom == 0)
                Spacer(
                  flex: 3,
                )
            ],
          ),
        ),
      ),
    );
  }
}
