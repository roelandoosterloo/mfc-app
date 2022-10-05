import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' show Page;
import 'package:mfc_app/screens/course/list/course_list_page.dart';
import 'package:mfc_app/screens/course/single/course_single_page.dart';
import 'package:mfc_app/screens/home/home_page.dart';
import 'package:mfc_app/screens/init/init_page.dart';
import 'package:mfc_app/screens/landing/landing_page.dart';
import 'package:mfc_app/screens/login/login_page.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_page.dart';
import 'package:mfc_app/screens/measurment/measurement_page.dart';
import 'package:mfc_app/screens/module/single/module_single_page.dart';
import 'package:mfc_app/screens/password_reset/password_reset_page.dart';
import 'package:mfc_app/screens/pdf_viewer/pdf_viewer_page.dart';
import 'package:mfc_app/screens/profile/profile_page.dart';
import 'package:mfc_app/screens/program/list/list_program_page.dart';
import 'package:mfc_app/screens/register/register_page.dart';
import 'package:mfc_app/utils/stack.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial(false)) {
    on<NavigatedBack>(_onNavigatedBack);
    on<NavigatedToRegister>(_onNavigatedToRegister);
    on<NavigatedToLogin>(_onNavigatedToLogin);
    on<ResetToLogin>(_onResetToLogin);
    on<NavigatedToResetPassword>(_onNavigatedToResetPassword);
    on<NavigatedToHome>(_onNavigatedToHome);
    on<NavigatedToMeasurements>(_onNavigatedToMeasurements);
    on<NavigatedToAddMeasurement>(_onNavigatedToAddMeasurement);
    on<NavigatedToCourse>(_onNavigatedToCourse);
    on<NavigatedToModule>(_onNavigatedToModule);
    on<NavigatedToCourseList>(_onNavigatedToCourseList);
    on<NavigatedToProfile>(_onNavigatedToProfile);
    on<NavigatedToPrograms>(_onNavigatedToPrograms);
    on<NavigatedToPdf>(_onNavigatedToPdf);
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

  void _onResetToLogin(
    ResetToLogin event,
    Emitter<NavigationState> emit,
  ) {
    emit(AuthenticationNavigation.initial().goTo(LoginPage()));
  }

  void _onNavigatedToResetPassword(
    NavigatedToResetPassword event,
    Emitter<NavigationState> emit,
  ) {
    if (state is AuthenticationNavigation) {
      return emit(state.goTo(PasswordResetPage(username: event.username)));
    }
    emit(AuthenticationNavigation.initial()
        .goTo(PasswordResetPage(username: event.username)));
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
      event.courseId,
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

  void _onNavigatedToPrograms(
    NavigatedToPrograms event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(ListProgramPage()));
  }

  void _onNavigatedToPdf(
    NavigatedToPdf event,
    Emitter<NavigationState> emit,
  ) {
    emit(state.goTo(PdfViewerPage(
      event.file,
      event.name,
      event.url,
    )));
  }
}
