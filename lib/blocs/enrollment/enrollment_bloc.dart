import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'enrollment_event.dart';
part 'enrollment_state.dart';

class EnrollmentBloc extends Bloc<EnrollmentEvent, EnrollmentState> {
  final CourseRepository _courseRepo;

  EnrollmentBloc(this._courseRepo) : super(EnrollmentInitial()) {
    on<EnrolledCoursesRequested>(_onListRequested);
    on<EnrolledCourseSelected>(_onCourseSelected);
  }

  void _onListRequested(
    EnrolledCoursesRequested event,
    Emitter<EnrollmentState> emit,
  ) async {
    try {
      emit(state.copyWith(loading: true, errorMessage: null));
      List<Enrollment> enrollments = await _courseRepo.listEnrolledCourses();
      emit(state.copyWith(enrollments: enrollments));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }

  void _onCourseSelected(
    EnrolledCourseSelected event,
    Emitter<EnrollmentState> emit,
  ) async {
    emit(state.copyWith(selected: event.selected));
    try {
      Enrollment? course = await _courseRepo.getEnrollment(event.selected.id);
      if (course != null) {
        emit(state.copyWith(selected: course));
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
