import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/Enrollment.dart';
import 'package:mfc_app/models/ModuleProgress.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'singlecoursepage_event.dart';
part 'singlecoursepage_state.dart';

class SingleCoursePageBloc
    extends Bloc<SingleCoursePageEvent, SingleCoursePageState> {
  final String _enrollmentId;
  final CourseRepository _courseRepository;
  final NavigationBloc _navBloc;

  SingleCoursePageBloc(
    this._enrollmentId, {
    required CourseRepository courseRepository,
    required NavigationBloc navigationBloc,
  })  : _courseRepository = courseRepository,
        _navBloc = navigationBloc,
        super(SinglecoursepageInitial()) {
    on<SingleCoursePageOpened>(_onSingleCoursePageOpened);
    on<SingleCoursePageModuleSelected>(_onSingleCoursePageModuleSelected);
  }

  void _onSingleCoursePageOpened(
    SingleCoursePageOpened event,
    Emitter<SingleCoursePageState> emit,
  ) async {
    try {
      emit(SingleCoursePageLoading());
      Enrollment? enrollment =
          await _courseRepository.getEnrollment(_enrollmentId);
      if (enrollment != null) {
        emit(SingleCoursePageLoaded(enrollment));
      }
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      emit(SingleCoursePageError(e.toString()));
    }
  }

  void _onSingleCoursePageModuleSelected(
    SingleCoursePageModuleSelected event,
    Emitter<SingleCoursePageState> emit,
  ) {
    if (event.module.startedAt == null) {
      _courseRepository.setModuleStartedAt(event.module);
    }
    _navBloc.add(NavigatedToModule(event.module.id));
  }
}
