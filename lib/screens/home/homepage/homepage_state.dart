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
  final bool loadingCourse;

  HomePageLoaded(this._courses, this._enrollments, this.profile,
      {this.loadingCourse = false});

  HomePageLoaded setCourseLoading(bool loading) {
    return HomePageLoaded(
      _courses,
      _enrollments,
      profile,
      loadingCourse: loading,
    );
  }

  List<Course> get courses {
    List<Course> courses = _enrollments
        .map(
          (e) => e.course,
        )
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

  Course? get highlightedCourse {
    String? currentCourse = profile.currentCourseId;
    if (currentCourse == null) {
      if (_enrollments.isEmpty) {
        return null;
      }
      return _enrollments[0].course;
    }
    return courses.firstWhere((element) => element.id == currentCourse);
  }

  List<Enrollment> get enrollments {
    return _enrollments;
  }

  @override
  List<Object> get props => [_courses, _enrollments, profile, loadingCourse];
}

class HomePageError extends HomePageState {
  final String error;

  HomePageError(this.error);

  @override
  List<Object> get props => [error];
}
