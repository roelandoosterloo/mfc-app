import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleBloc extends Bloc<ModuleEvent, ModuleState> {
  final CourseRepository _courseRepo;

  ModuleBloc({required CourseRepository courseRepo})
      : _courseRepo = courseRepo,
        super(ModuleInitial());

  @override
  Stream<ModuleState> mapEventToState(ModuleEvent event) async* {
    if (event is ModuleSelected) {
      yield* _mapModuleSelectedToState(event.courseId, event.moduleId);
    }
  }

  Stream<ModuleState> _mapModuleSelectedToState(
    String courseId,
    String moduleId,
  ) async* {
    yield ModuleLoading();
    try {
      Module? module = await _courseRepo.getModule(courseId, moduleId);
      if (module != null) {
        yield ModuleAvailable(module: module);
      } else {
        yield ModuleNotFound();
      }
    } catch (ex) {
      print(ex);
      yield ModuleLoadingFailed(error: ex.toString());
    }
  }
}
