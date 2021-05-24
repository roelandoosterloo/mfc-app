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
