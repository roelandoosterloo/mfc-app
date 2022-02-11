import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/login/login_event.dart';
import 'package:mfc_app/blocs/login/login_state.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepo;
  AuthenticationBloc _authBloc;

  LoginBloc({
    required UserRepository userRepo,
    required AuthenticationBloc authBloc,
  })  : _userRepo = userRepo,
        _authBloc = authBloc,
        super(LoggingIn.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithCredentialsSubmitted>(_onLoginSubmitted);
    on<LoginConfirmationSubmitted>(_onConfirmationSubmitted);
    on<LoginCodeChanged>(_onNewPasswordChanged);
    on<LoginRepeatChanged>(_onRepeatChanged);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    if (state is LoggingIn) {
      emit((state as LoggingIn)
          .update(isEmailValid: Validators.isValidEmail(event.email)));
    }
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    if (state is LoggingIn) {
      emit(
        (state as LoggingIn).update(
          isPasswordValid: Validators.isNumberOfCharacters(
            lower: 8,
            value: event.password,
          ),
        ),
      );
    }
  }

  void _onNewPasswordChanged(
    LoginCodeChanged event,
    Emitter<LoginState> emit,
  ) {
    if (state is SetupPassword) {
      emit((state as SetupPassword).copyWith(
        isPasswordValid: Validators.isValidPassword(event.code),
      ));
    }
  }

  void _onRepeatChanged(
    LoginRepeatChanged event,
    Emitter<LoginState> emit,
  ) {
    if (state is SetupPassword) {
      emit((state as SetupPassword).copyWith(
        isRepeatValid: event.repeat == event.password,
      ));
    }
  }

  void _onLoginSubmitted(
    LoginWithCredentialsSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoggingIn.loading());
    try {
      SignInResult result = await _userRepo.signIn(event.email, event.password);
      if (result.isSignedIn) {
        emit(LoggingIn.success());
        _authBloc.add(AuthenticationLoggedIn());
      } else {
        if (result.nextStep?.signInStep ==
            "CONFIRM_SIGN_IN_WITH_NEW_PASSWORD") {
          emit(SetupPassword.initial());
        }
      }
    } on AmplifyException catch (ex) {
      print(ex);
      emit(LoggingIn.failure(error: ex.message));
    }
  }

  void _onConfirmationSubmitted(
    LoginConfirmationSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(SetupPassword.loading());
    try {
      SignInResult result = await _userRepo.confirmSignIn(event.code);
      if (result.isSignedIn) {
        emit(LoggingIn.success());
      } else {
        emit(SetupPassword.failure(error: "Login not confirmed"));
      }
    } on AmplifyException catch (ex) {
      print(ex);
      emit(LoggingIn.failure(error: ex.message));
    }
  }
}
