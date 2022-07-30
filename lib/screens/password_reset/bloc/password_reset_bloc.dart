import 'dart:convert';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';

part 'password_reset_event.dart';
part 'password_reset_state.dart';

class PasswordResetBloc extends Bloc<PasswordResetEvent, PasswordResetState> {
  final UserRepository _userRepo;
  final NavigationBloc _navBloc;
  final String? _username;

  PasswordResetBloc({
    required UserRepository userRepo,
    required NavigationBloc navBloc,
    String? username,
  })  : _userRepo = userRepo,
        _navBloc = navBloc,
        _username = username,
        super(PasswordResetEmailStep()) {
    on<EmailChanged>(_onEmailChanged);
    on<CodeChanged>(_onCodeChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PasswordRepeatChanged>(_onPasswordRepeatChanged);
    on<RequestSubmitted>(_onResetRequested);
    on<ResetConfirmed>(_onResetConfirmed);

    if (username != null) {
      this.add(RequestSubmitted(email: username));
    }
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    bool valid = Validators.isValidEmail(event.email);
    emit(
      PasswordResetEmailStep(
        emailValid: valid,
      ),
    );
  }

  void _onCodeChanged(
    CodeChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    if (state is PasswordResetCodeStep) {
      emit((state as PasswordResetCodeStep).update(
        isCodeValid: Validators.isNotEmpty(event.code),
      ));
    }
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    if (state is PasswordResetCodeStep) {
      emit((state as PasswordResetCodeStep).update(
        isPasswordValid: Validators.isValidPassword(event.password),
      ));
    }
  }

  void _onPasswordRepeatChanged(
    PasswordRepeatChanged event,
    Emitter<PasswordResetState> emit,
  ) {
    if (state is PasswordResetCodeStep) {
      emit((state as PasswordResetCodeStep).update(
        isRepeatValid: event.repeat == event.password,
      ));
    }
  }

  void _onResetRequested(
    RequestSubmitted event,
    Emitter<PasswordResetState> emit,
  ) async {
    if (state is PasswordResetEmailStep) {
      try {
        ResetPasswordResult result =
            await _userRepo.requestPasswordReset(event.email);
        emit(PasswordResetCodeStep(event.email, result));
      } on AmplifyException catch (ex) {
        emit((state as PasswordResetEmailStep).failure(ex.message));
      }
    }
  }

  void _onResetConfirmed(
    ResetConfirmed event,
    Emitter<PasswordResetState> emit,
  ) async {
    if (state is PasswordResetCodeStep) {
      try {
        UpdatePasswordResult result = await _userRepo.confirmPasswordReset(
            (state as PasswordResetCodeStep).email, event.password, event.code);
        _navBloc.add(NavigatedToLogin());
      } on AmplifyException catch (ex) {
        emit((state as PasswordResetCodeStep).failure(ex.message));
      }
    }
  }
}
