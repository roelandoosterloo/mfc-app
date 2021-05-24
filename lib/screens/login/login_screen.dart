import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/login/login_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/login/login_form.dart';
import 'package:mfc_app/widgets/curved_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = context.read<UserRepository>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepo: _userRepository),
        child: Container(
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                CurvedWidget(
                  child: Container(
                    padding: const EdgeInsets.only(top: 75, left: 50),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xff2b8474),
                          Color(0xff2b8474),
                          Color(0xff2b8474).withOpacity(0.2),
                        ],
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 250),
                  child: LoginForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
