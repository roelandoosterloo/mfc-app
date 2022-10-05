import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/Answer.dart';
import 'package:mfc_app/models/Enrollment.dart';
import 'package:mfc_app/models/ModuleProgress.dart';
import 'package:mfc_app/models/Question.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/utils/helpers.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
    } catch (ex, s) {
      await Sentry.captureException(ex, stackTrace: s);
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
          event.question,
          event.progress.id,
          event.value,
        );
      } else {
        await _courseRepo.updateAnswer(
          event.answer!,
          event.value,
        );
      }
    } catch (ex, stack) {
      await Sentry.captureException(ex, stackTrace: stack);
      print(ex);
    }
  }

  Future<bool> completeCourseWhenDone(String enrollmentId) async {
    Enrollment? enrollment = await _courseRepo.getEnrollment(enrollmentId);
    if (enrollment != null &&
        enrollment.moduleSchedule != null &&
        isEnrollmentCourseDone(enrollment)) {
      return await _courseRepo.completeCourse(enrollment);
    }
    return false;
  }

  void _onModuleCompleted(
    ModuleCompleted event,
    Emitter<ModuleProgressState> emit,
  ) async {
    try {
      await _courseRepo.completeModule(event.moduleProgress);
      ModuleProgress mp = event.moduleProgress;
      String enrollmentId = mp.enrollmentId;
      await completeCourseWhenDone(enrollmentId);

      _navBloc.add(NavigatedBack());
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
    }
  }
}
