part of 'single_course_bloc.dart';

abstract class SingleCourseEvent extends Equatable {
  const SingleCourseEvent();

  @override
  List<Object> get props => [];
}

class CourseSelected extends SingleCourseEvent {
  final String _courseId;

  CourseSelected(this._courseId);

  String get courseId => _courseId;

  @override
  List<Object> get props => [_courseId];
}

class CourseFound extends SingleCourseEvent {
  final Course _course;

  CourseFound(this._course);

  Course get course => _course;

  @override
  List<Object> get props => [_course];
}
