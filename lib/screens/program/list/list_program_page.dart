import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/repositories/program_repository.dart';
import 'package:mfc_app/repositories/store_repository.dart';
import 'package:mfc_app/screens/program/list/bloc/list_program_bloc.dart';

import 'list_program_screen.dart';

class ListProgramPage extends Page {
  ListProgramPage() : super(name: "ListProgramPage");
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => ListProgramBloc(
            programRepo: context.read<ProgramRepository>(),
            storeRepo: context.read<StoreRepository>(),
          ),
          child: ListProgramScreen(),
        );
      },
    );
  }
}
