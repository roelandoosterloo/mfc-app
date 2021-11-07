part of 'single_course_bloc.dart';

abstract class SingleCourseState extends Equatable {
  const SingleCourseState();

  @override
  List<Object> get props => [];
}

class SingleInitial extends SingleCourseState {}

class CourseLoading extends SingleCourseState {}

class CourseAvailable extends SingleCourseState {
  final Enrollment _course;

  CourseAvailable({required Enrollment course}) : _course = course;

  Enrollment get course => _course;

  @override
  List<Object> get props => [_course];
}

class CourseLoadingFailed extends SingleCourseState {
  final String _error;

  CourseLoadingFailed({String error = ""}) : _error = error;

  String get error => error;

  @override
  List<Object> get props => [_error];
}

class CourseNotFound extends SingleCourseState {}
