import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/register/bloc/register_bloc.dart';
import 'package:mfc_app/screens/register/confirm_code_form.dart';
import 'package:mfc_app/screens/register/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = context.read<UserRepository>();
    ProfileRepository _profileRepository = context.read<ProfileRepository>();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(
          userRepo: _userRepository,
          profileRepo: _profileRepository,
        ),
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
                BlocConsumer<RegisterBloc, RegisterState>(
                  listener: (context, state) {
                    if (state.isFailure) {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(state.error ?? "Er ging iets fout"),
                          ),
                        );
                    }
                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                                "Account aangemaakt. Log in om door te gaan"),
                          ),
                        );
                      NavigationBloc _navBloc =
                          BlocProvider.of<NavigationBloc>(context);
                      _navBloc.add(NavigatedToLogin());
                    }
                  },
                  builder: (context, state) {
                    if (state is Registering) {
                      return Container(child: RegisterForm());
                    }
                    if (state is ConfirmRegistration) {
                      return Container(child: ConfirmCodeForm());
                    }
                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
