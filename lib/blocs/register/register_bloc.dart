import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/register/register_event.dart';
import 'package:mfc_app/blocs/register/register_state.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepo;

  RegisterBloc({required UserRepository userRepo})
      : _userRepo = userRepo,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterEmailChanged) {
      yield* _mapEmailChangedToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapPasswordChangedToState(event.password);
    } else if (event is RegisterWithCredentialsSubmitted) {
      yield* _mapRegisterWithCredentailsSubmittedToState(
          event.email, event.password);
    }
  }

  Stream<RegisterState> _mapEmailChangedToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapPasswordChangedToState(String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterWithCredentailsSubmittedToState(
      String email, String password) async* {
    yield RegisterState.loading();
    try {
      await _userRepo.createUser(email, password);
      yield RegisterState.success();
    } on FirebaseAuthException catch (ex) {
      print(ex);
      yield RegisterState.failure(errorMessage: ex.message);
    } catch (ex) {
      print(ex);
      yield RegisterState.failure();
    }
  }
}
