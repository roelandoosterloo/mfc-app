part of 'course_list_bloc.dart';

abstract class CourseListEvent extends Equatable {
  const CourseListEvent();

  @override
  List<Object> get props => [];
}

class CourseListRequested extends CourseListEvent {}

class CourseListFound extends CourseListEvent {
  final List<Enrollment> courses;

  CourseListFound(this.courses);
}

class CourseListLoadingFailed extends CourseListEvent {
  final String error;

  CourseListLoadingFailed(this.error);
}
