import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/login/login_bloc.dart';
import 'package:mfc_app/blocs/login/login_state.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/login/login_form.dart';
import 'package:mfc_app/screens/login/setup_password_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserRepository _userRepository = context.read<UserRepository>();
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);

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
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state.isFailure) {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Login mislukt",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    if (state.error != null &&
                                        state.error!.isNotEmpty)
                                      Flexible(
                                        child: Text(
                                          state.error!,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      )
                                  ],
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
                    if (state.isSuccess) {
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      _navBloc.add(NavigatedToHome());
                    }
                  },
                  builder: (context, state) {
                    if (state is LoggingIn) {
                      return LoginForm();
                    }
                    if (state is SetupPassword) {
                      return SetupPasswordForm();
                    }
                    return Container();
                  },
                ),
                // if (MediaQuery.of(context).viewInsets.bottom == 0)
                //   Spacer(
                //     flex: 3,
                //   )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
