import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/password_reset/bloc/password_reset_bloc.dart';
import 'package:mfc_app/screens/password_reset/password_reset_screen.dart';

class PasswordResetPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider<PasswordResetBloc>(
        create: (context) => PasswordResetBloc(
          userRepo: context.read<UserRepository>(),
          navBloc: context.read<NavigationBloc>(),
        ),
        child: PasswordResetScreen(),
      ),
    );
  }
}
