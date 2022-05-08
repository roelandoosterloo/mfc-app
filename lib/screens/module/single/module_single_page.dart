import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/course/module/module_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/screens/module/single/module_single_screen.dart';

class ModuleSinglePage extends Page {
  final String progressId;

  ModuleSinglePage(this.progressId) : super(name: "ModuleSinglePage");

  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (context) => BlocProvider(
        create: (context) => ModuleProgressBloc(
          courseRepo: context.read<CourseRepository>(),
          navBloc: context.read<NavigationBloc>(),
        ),
        child: ModuleSingleScreen(
          progressId: progressId,
        ),
      ),
    );
  }
}
