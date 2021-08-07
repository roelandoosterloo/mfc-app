part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

class NavigatedBack extends NavigationEvent {}

class NavigatedToRegister extends NavigationEvent {}

class NavigatedToLogin extends NavigationEvent {}

class NavigatedToHome extends NavigationEvent {}

class NavigatedToMeasurements extends NavigationEvent {}

class NavigatedToAddMeasurement extends NavigationEvent {}

class NavigatedToCourseList extends NavigationEvent {}

class NavigatedToCourse extends NavigationEvent {
  final String courseId;

  NavigatedToCourse(this.courseId);

  @override
  List<Object> get props => [courseId];
}

class NavigatedToModule extends NavigationEvent {
  final String courseId;
  final String moduleId;

  NavigatedToModule(this.courseId, this.moduleId);

  @override
  List<Object> get props => [courseId, moduleId];
}