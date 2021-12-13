import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Page;
import 'package:mfc_app/screens/course/list/course_list_page.dart';
import 'package:mfc_app/screens/course/single/course_single_page.dart';
import 'package:mfc_app/screens/home/home_page.dart';
import 'package:mfc_app/screens/login/login_page.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_page.dart';
import 'package:mfc_app/screens/measurment/measurement_page.dart';
import 'package:mfc_app/screens/module/single/module_single_page.dart';
import 'package:mfc_app/screens/profile/profile_page.dart';
import 'package:mfc_app/screens/register/register_page.dart';
import 'package:mfc_app/utils/stack.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial()) {
    on<NavigatedBack>(_onNavigatedBack);
    on<NavigatedToRegister>(_onNavigatedToRegister);
    on<NavigatedToLogin>(_onNavigatedToLogin);
    on<NavigatedToHome>(_onNavigatedToHome);
    on<NavigatedToMeasurements>(_onNavigatedToMeasurements);
    on<NavigatedToAddMeasurement>(_onNavigatedToAddMeasurement);
    on<NavigatedToCourse>(_onNavigatedToCourse);
    on<NavigatedToModule>(_onNavigatedToModule);
    on<NavigatedToCourseList>(_onNavigatedToCourseList);
    on<NavigatedToProfile>(_onNavigatedToProfile);
  }

  void _onNavigatedBack(
    NavigatedBack event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goBack());
  }

  void _onNavigatedToRegister(
    NavigatedToRegister event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(RegisterPage()));
  }

  void _onNavigatedToLogin(
    NavigatedToLogin event,
    Emitter<NavigationState> emit,
  ) {
    if (state is AuthenticationNavigation) {
      return emit(state.goTo(LoginPage()));
    }
    emit(AuthenticationNavigation.initial());
  }

  void _onNavigatedToHome(
    NavigatedToHome event,
    Emitter<NavigationState> emit,
  ) {
    if (state is AuthenticationNavigation) {
      emit(state.goTo(HomePage()));
    }
    return emit(AppNavigation.initial());
  }

  void _onNavigatedToMeasurements(
    NavigatedToMeasurements event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(MeasurementPage()));
  }

  void _onNavigatedToAddMeasurement(
    NavigatedToAddMeasurement event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(AddMeasurementPage()));
  }

  void _onNavigatedToCourseList(
    NavigatedToCourseList event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(CourseListPage()));
  }

  void _onNavigatedToCourse(
    NavigatedToCourse event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(CourseSinglePage(
        // event.courseId,
        )));
  }

  void _onNavigatedToModule(
    NavigatedToModule event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(ModuleSinglePage(event.moduleProgressId)));
  }

  void _onNavigatedToProfile(
    NavigatedToProfile event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(ProfilePage()));
  }
}
