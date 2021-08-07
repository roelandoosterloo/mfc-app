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
  final bool isCourse;

  AppNavigation({
    this.isHome = false,
    this.isMeasurments = false,
    this.isAddMeasurement = false,
    this.isCourse = false,
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
    if (isCourse) {
      return AppNavigation.home();
    }

    return AppNavigation.home();
  }

  @override
  List<Object> get props => [
        this.isHome,
        this.isMeasurments,
        this.isAddMeasurement,
        this.isCourse,
      ];
}

class CourseNavigation extends AppNavigation {
  final String? courseId;
  final String? moduleId;

  CourseNavigation({
    this.courseId,
    this.moduleId,
  });

  factory CourseNavigation.courseList() {
    return CourseNavigation();
  }

  factory CourseNavigation.course(String courseId) {
    return CourseNavigation(courseId: courseId);
  }

  factory CourseNavigation.module(String moduleId) {
    return CourseNavigation(moduleId: moduleId);
  }

  CourseNavigation update({String? courseId, String? moduleId}) {
    return CourseNavigation(
      courseId: courseId ?? this.courseId,
      moduleId: moduleId ?? this.moduleId,
    );
  }

  @override
  NavigationState goBack() {
    if (courseId != null && moduleId != null) {
      return CourseNavigation.course(this.courseId!);
    }
    if (courseId != null) {
      return CourseNavigation.courseList();
    }
    return AppNavigation.home();
  }

  @override
  List<Object> get props => [
        courseId ?? "",
        moduleId ?? "",
      ];
}
