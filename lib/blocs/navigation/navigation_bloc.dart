import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    if (event is NavigatedBack) {
      yield* _mapBackToState();
    } else if (event is NavigatedToRegister) {
      yield* _mapRegisterClickedToState();
    } else if (event is NavigatedToLogin) {
      yield* _mapLoginToState();
    } else if (event is NavigatedToHome) {
      yield* _mapHomeToState();
    } else if (event is NavigatedToMeasurements) {
      yield* _mapMeasurementsToState();
    } else if (event is NavigatedToAddMeasurement) {
      yield* _mapAddMeasurementToState();
    } else if (event is NavigatedToCourse) {
      yield* _mapCourseToState(event.courseId);
    } else if (event is NavigatedToModule) {
      yield* _mapModuleToState(event.moduleProgressId);
    } else if (event is NavigatedToCourseList) {
      yield* _mapCourseListToState();
    }
  }

  Stream<NavigationState> _mapBackToState() async* {
    yield state.goBack();
  }

  Stream<NavigationState> _mapRegisterClickedToState() async* {
    yield AuthenticationNavigation.register();
  }

  Stream<NavigationState> _mapLoginToState() async* {
    yield AuthenticationNavigation.login();
  }

  Stream<NavigationState> _mapHomeToState() async* {
    yield AppNavigation.home();
  }

  Stream<NavigationState> _mapMeasurementsToState() async* {
    yield AppNavigation(isMeasurments: true);
  }

  Stream<NavigationState> _mapAddMeasurementToState() async* {
    yield AppNavigation.addMeasurement();
  }

  Stream<NavigationState> _mapCourseListToState() async* {
    yield CourseNavigation.courseList();
  }

  Stream<NavigationState> _mapCourseToState(String courseId) async* {
    yield CourseNavigation.course(courseId);
  }

  Stream<NavigationState> _mapModuleToState(String moduleId) async* {
    if (state is CourseNavigation) {
      yield (state as CourseNavigation).update(moduleId: moduleId);
    } else {
      yield CourseNavigation.module(moduleId);
    }
  }
}
