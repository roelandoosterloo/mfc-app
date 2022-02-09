import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/login/login_event.dart';
import 'package:mfc_app/blocs/login/login_state.dart';
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
        super(LoginState.initial()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginWithCredentialsSubmitted>(_onLoginSubmitted);
    on<LoginConfirmationSubmitted>(_onConfirmationSubmitted);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.update(
        isPasswordValid: Validators.isValidPassword(event.password),
      ),
    );
  }

  void _onLoginSubmitted(
    LoginWithCredentialsSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      SignInResult result = await _userRepo.signIn(event.email, event.password);
      if (result.isSignedIn) {
        emit(LoginState.success());
        _authBloc.add(AuthenticationLoggedIn());
      } else {
        emit(LoginState.confirmationNeeded(result.nextStep));
      }
    } catch (ex) {
      print(ex);
      emit(LoginState.failure());
    }
  }

  void _onConfirmationSubmitted(
    LoginConfirmationSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading());
    try {
      SignInResult result = await _userRepo.confirmSignIn(event.code);
      if (result.isSignedIn) {
        emit(LoginState.success());
      } else {
        emit(LoginState.failure(error: "Login not confirmed"));
      }
    } catch (ex) {
      print(ex);
      emit(LoginState.failure(error: ex.toString()));
    }
  }
}
