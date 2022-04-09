part of 'homepage_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object?> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final List<Course> _courses;
  final List<Enrollment> _enrollments;
  final Profile profile;
  final String? loadingCourse;

  HomePageLoaded(this._courses, this._enrollments, this.profile,
      {this.loadingCourse});

  HomePageLoaded setCourseLoading(String? loadingCourse) {
    return HomePageLoaded(
      _courses,
      _enrollments,
      profile,
      loadingCourse: loadingCourse,
    );
  }

  List<Course> get courses {
    List<Course> courses = _enrollments
        .where((element) => !element.isCourseDone())
        .map((e) => e.course)
        .toList();
    courses.addAll(_courses.where((element) =>
        !_enrollments.map((e) => e.course.id).contains(element.id)));
    return courses;
  }

  Enrollment? get currentEnrollment {
    String? currentCourseId = profile.currentCourseId;
    if (_enrollments.isEmpty) return null;
    if (currentCourseId == null) return _enrollments[0];

    return _enrollments
        .firstWhere((element) => element.course.id == currentCourseId);
  }

  List<Course> get completedCourses {
    return _enrollments
        .where((element) => element.isCourseDone())
        .map((e) => e.course)
        .toList();
  }

  List<Enrollment> get enrollments {
    return _enrollments;
  }

  bool isCourseDone(String courseId) {
    return completedCourses.any((element) => element.id == courseId);
  }

  @override
  List<Object?> get props => [_courses, _enrollments, profile, loadingCourse];
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError(this.error);

  @override
  List<Object> get props => [error];
}
