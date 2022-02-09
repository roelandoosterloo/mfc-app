part of 'singlecoursepage_bloc.dart';

abstract class SingleCoursePageState extends Equatable {
  const SingleCoursePageState();

  @override
  List<Object> get props => [];
}

class SinglecoursepageInitial extends SingleCoursePageState {}

class SingleCoursePageLoading extends SingleCoursePageState {}

class SingleCoursePageLoaded extends SingleCoursePageState {
  final Enrollment _enrollment;

  SingleCoursePageLoaded(_enrollment) : _enrollment = _enrollment;

  get enrollment {
    return _enrollment;
  }

  @override
  List<Object> get props => [_enrollment];
}

class SingleCoursePageError extends SingleCoursePageState {
  final String _message;

  SingleCoursePageError(this._message);

  get message {
    return _message;
  }

  @override
  List<Object> get props => [_message];
}
