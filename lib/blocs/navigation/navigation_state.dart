part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  const NavigationState();

  NavigationState goBack();

  @override
  List<Object> get props => [];
}

class NavigationInitial extends NavigationState {
  @override
  NavigationState goBack() {
    return NavigationInitial();
  }
}

class AuthenticationNavigation extends NavigationState {
  final bool isLogin;
  final bool isRegister;

  AuthenticationNavigation({
    required this.isLogin,
    required this.isRegister,
  });

  factory AuthenticationNavigation.initial() {
    return AuthenticationNavigation(isLogin: true, isRegister: false);
  }

  factory AuthenticationNavigation.login() {
    return AuthenticationNavigation(isLogin: true, isRegister: false);
  }

  factory AuthenticationNavigation.register() {
    return AuthenticationNavigation(isLogin: false, isRegister: true);
  }

  @override
  NavigationState goBack() {
    if (isRegister) {
      return AuthenticationNavigation.login();
    }
    if (isLogin) {
      return AuthenticationNavigation.login();
    }

    return AuthenticationNavigation.login();
  }

  @override
  List<Object> get props => [isLogin, isRegister];
}

class AppNavigation extends NavigationState {
  final bool isHome;
  final bool isMeasurments;
  final bool isAddMeasurement;

  AppNavigation({
    this.isHome = false,
    this.isMeasurments = false,
    this.isAddMeasurement = false,
  });

  factory AppNavigation.home() {
    return AppNavigation(
      isHome: true,
    );
  }

  factory AppNavigation.measurements() {
    return AppNavigation(
      isMeasurments: true,
    );
  }

  factory AppNavigation.addMeasurement() {
    return AppNavigation(
      isMeasurments: true,
      isAddMeasurement: true,
    );
  }

  @override
  NavigationState goBack() {
    if (isAddMeasurement) {
      return AppNavigation.measurements();
    }
    if (isMeasurments) {
      return AppNavigation.home();
    }
    if (isHome) {
      return AppNavigation.home();
    }

    return AppNavigation.home();
  }

  @override
  List<Object> get props => [
        this.isHome,
        this.isMeasurments,
        this.isAddMeasurement,
      ];
}
