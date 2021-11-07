part of 'course_list_bloc.dart';

abstract class CourseListState extends Equatable {
  const CourseListState();

  @override
  List<Object> get props => [];
}

class CourseInitial extends CourseListState {}

class CourseListLoading extends CourseListState {}

class CourseListAvailable extends CourseListState {
  final List<Enrollment> _courses;

  CourseListAvailable({required List<Enrollment> courses}) : _courses = courses;

  List<Enrollment> get courses => _courses;

  @override
  List<Object> get props => [_courses];
}

class CourseListFailed extends CourseListState {
  final String _error;

  CourseListFailed({String error = ""}) : _error = error;

  String? get error => _error;

  @override
  List<Object> get props => [_error];
}
