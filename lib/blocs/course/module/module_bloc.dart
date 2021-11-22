import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleProgressBloc
    extends Bloc<ModuleProgressEvent, ModuleProgressState> {
  final CourseRepository _courseRepo;

  ModuleProgressBloc({required CourseRepository courseRepo})
      : _courseRepo = courseRepo,
        super(ModuleProgressInitial());

  @override
  Stream<ModuleProgressState> mapEventToState(
      ModuleProgressEvent event) async* {
    if (event is ModuleProgressSelected) {
      yield* _mapModuleProgressSelectedToState(event.moduleprogressId);
    } else if (event is AnswerGiven) {
      yield* _mapAnswerGivenToState(event.question, event.answer);
    }
  }

  Stream<ModuleProgressState> _mapModuleProgressSelectedToState(
    String moduleprogressId,
  ) async* {
    yield ModuleProgressLoading();
    try {
      ModuleProgress? progress =
          await _courseRepo.getModuleProgress(moduleprogressId);
      if (progress != null) {
        yield ModuleProgressAvailable(moduleprogress: progress);
      } else {
        yield ModuleProgressNotFound();
      }
    } catch (ex) {
      print(ex);
      yield ModuleProgressLoadingFailed(error: ex.toString());
    }
  }

  Stream<ModuleProgressState> _mapAnswerGivenToState(
    Question question,
    String answer,
  ) async* {
    print(answer);
    try {
      if (question.answer == null) {
        await _courseRepo.createAnswer(question.id, "", answer);
      } else {
        await _courseRepo.updateAnswer(question.answer!.id, answer);
      }
    } catch (ex) {
      print(ex);
    }
  }
}
