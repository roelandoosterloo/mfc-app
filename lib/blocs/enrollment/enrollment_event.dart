part of 'enrollment_bloc.dart';

abstract class EnrollmentEvent extends Equatable {
  const EnrollmentEvent();

  @override
  List<Object> get props => [];
}

class EnrolledCoursesRequested extends EnrollmentEvent {}

class EnrolledCourseSelected extends EnrollmentEvent {
  final Enrollment selected;

  EnrolledCourseSelected(this.selected);

  @override
  List<Object> get props => [selected];
}

class EnrollmentsFound extends EnrollmentEvent {
  final List<Enrollment> enrollments;

  EnrollmentsFound(this.enrollments);

  @override
  List<Object> get props => [enrollments];
}

class RequestFailed extends EnrollmentEvent {
  final String error;

  RequestFailed(this.error);

  @override
  List<Object> get props => [error];
}
