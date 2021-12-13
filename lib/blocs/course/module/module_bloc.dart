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
        super(ModuleProgressInitial()) {
    on<ModuleProgressSelected>(_onModuleSelected);
    on<AnswerGiven>(_onAnswerGiven);
  }

  void _onModuleSelected(
    ModuleProgressSelected event,
    Emitter<ModuleProgressState> emit,
  ) async {
    emit(ModuleProgressLoading());
    try {
      ModuleProgress? progress =
          await _courseRepo.getModuleProgress(event.moduleprogressId);
      if (progress != null) {
        emit(ModuleProgressAvailable(moduleprogress: progress));
      } else {
        emit(ModuleProgressNotFound());
      }
    } catch (ex) {
      print(ex);
      emit(ModuleProgressLoadingFailed(error: ex.toString()));
    }
  }

  void _onAnswerGiven(
    AnswerGiven event,
    Emitter<ModuleProgressState> emit,
  ) async {
    try {
      if (event.question.answer == null) {
        await _courseRepo.createAnswer(
          event.question.id,
          event.progress.id,
          event.answer,
        );
      } else {
        await _courseRepo.updateAnswer(
          event.question.answer!.id,
          event.answer,
        );
      }
    } catch (ex) {
      print(ex);
    }
  }
}
