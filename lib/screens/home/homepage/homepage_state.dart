part of 'homepage_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Course> _courses;
  final List<Enrollment> _enrollments;
  final Profile profile;

  HomePageLoaded(this._courses, this._enrollments, this.profile);

  List<Course> get courses {
    return _courses
        .where((element) =>
            !_enrollments.map((e) => e.course.id).contains(element.id))
        .toList();
  }

  List<Enrollment> get enrollments {
    return _enrollments;
  }

  @override
  List<Object> get props => [_courses, _enrollments, profile];
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError(this.error);

  @override
  List<Object> get props => [error];
}
