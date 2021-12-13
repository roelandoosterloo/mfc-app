import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/register/register_event.dart';
import 'package:mfc_app/blocs/register/register_state.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepo;

  RegisterBloc({required UserRepository userRepo})
      : _userRepo = userRepo,
        super(RegisterState.initial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterWithCredentialsSubmitted>(_onRegisterWithCredentailsSubmitted);
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.update(
        isPasswordValid: Validators.isValidPassword(event.password)));
  }

  _onRegisterWithCredentailsSubmitted(
    RegisterWithCredentialsSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterState.loading());
    try {
      await _userRepo.createUser(event.email, event.password);
      emit(RegisterState.success());
    } catch (ex) {
      print(ex);
      emit(RegisterState.failure());
    }
  }
}
