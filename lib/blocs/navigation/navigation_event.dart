part of 'navigation_bloc.dart';

abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object?> get props => [];
}

class NavigatedBack extends NavigationEvent {}

class NavigatedToRegister extends NavigationEvent {}

class NavigatedToLogin extends NavigationEvent {}

class ResetToLogin extends NavigationEvent {}

class NavigatedToResetPassword extends NavigationEvent {
  final String? _username;

  NavigatedToResetPassword({String? username})
      : _username = username,
        super();

  String? get username => _username;

  @override
  List<Object?> get props => [_username];
}

class NavigatedToHome extends NavigationEvent {}

class NavigatedToMeasurements extends NavigationEvent {}

class NavigatedToAddMeasurement extends NavigationEvent {}

class NavigatedToCourseList extends NavigationEvent {}

class NavigatedToProfile extends NavigationEvent {}

class NavigatedToCourse extends NavigationEvent {
  final String courseId;

  NavigatedToCourse(this.courseId);

  @override
  List<Object> get props => [courseId];
}

class NavigatedToModule extends NavigationEvent {
  final String moduleProgressId;

  NavigatedToModule(this.moduleProgressId);

  @override
  List<Object> get props => [moduleProgressId];
}

class NavigatedToPrograms extends NavigationEvent {}
