import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/login/login_event.dart';
import 'package:mfc_app/blocs/login/login_state.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository _userRepo;

  LoginBloc({required UserRepository userRepo})
      : _userRepo = userRepo,
        super(LoginState.initial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is LoginPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is LoginWithCredentialsSubmitted) {
      yield* _mapLoginWithCredentailsSubmittedToState(
        event.email,
        event.password,
      );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<LoginState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<LoginState> _mapLoginWithCredentailsSubmittedToState(
      String email, String password) async* {
    yield LoginState.loading();
    try {
      await _userRepo.signIn(email, password);
      yield LoginState.success();
    } catch (_) {
      yield LoginState.failure();
    }
  }
}
