import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/course/Answer.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';
import 'package:mfc_app/models/course/Question.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'module_event.dart';
part 'module_state.dart';

class ModuleProgressBloc
    extends Bloc<ModuleProgressEvent, ModuleProgressState> {
  final CourseRepository _courseRepo;
  final NavigationBloc _navBloc;

  ModuleProgressBloc({
    required CourseRepository courseRepo,
    required NavigationBloc navBloc,
  })  : _courseRepo = courseRepo,
        _navBloc = navBloc,
        super(ModuleProgressInitial()) {
    on<ModuleProgressSelected>(_onModuleSelected);
    on<AnswerGiven>(_onAnswerGiven);
    on<ModuleCompleted>(_onModuleCompleted);
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
      if (event.answer == null) {
        await _courseRepo.createAnswer(
          event.question.id,
          event.progress.id,
          event.value,
        );
      } else {
        await _courseRepo.updateAnswer(
          event.answer!.id,
          event.value,
        );
      }
    } catch (ex) {
      print(ex);
    }
  }

  void _onModuleCompleted(
    ModuleCompleted event,
    Emitter<ModuleProgressState> emit,
  ) async {
    try {
      _courseRepo.completeModule(event.moduleProgressId);
      _navBloc.add(NavigatedBack());
    } catch (ex) {
      print(ex);
    }
  }
}
