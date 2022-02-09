import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/home/home_screen.dart';

import 'homepage/homepage_bloc.dart';

class HomePage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => HomePageBloc(
            courseRepo: context.read<CourseRepository>(),
            profileRepo: context.read<ProfileRepository>(),
            userRepo: context.read<UserRepository>(),
            navBloc: BlocProvider.of<NavigationBloc>(context),
          ),
          child: HomeScreen(),
        );
      },
    );
  }
}
