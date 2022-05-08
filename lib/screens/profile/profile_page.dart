import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/profile/profile_bloc.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/screens/profile/profile_screen.dart';

class ProfilePage extends Page {
  ProfilePage() : super(name: "ProfilePage");
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => ProfileBloc(
          profileRepo: context.read<ProfileRepository>(),
          // locale: Localizations.maybeLocaleOf(context),
        ),
        child: ProfileScreen(),
      ),
    );
  }
}
