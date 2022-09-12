import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/validators.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  UserRepository _userRepo;
  ProfileRepository _profileRepo;

  RegisterBloc({
    required UserRepository userRepo,
    required ProfileRepository profileRepo,
  })  : _userRepo = userRepo,
        _profileRepo = profileRepo,
        super(Registering.initial()) {
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RepeatPasswordChanged>(_onRepeatChanged);
    on<RegisterWithCredentialsSubmitted>(_onRegisterWithCredentailsSubmitted);
    on<ConfirmCodeSubmitted>(_onConfirmCodeSubmitted);
    on<SignUpCompleted>(_onSignUpCompleted);
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit((state as Registering)
        .update(isEmailValid: Validators.isValidEmail(event.email)));
  }

  _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) async {
    emit((state as Registering)
        .update(isPasswordValid: Validators.isValidPassword(event.password)));
  }

  _onRepeatChanged(
    RepeatPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit((state as Registering)
        .update(isRepeatValid: event.password == event.repeat));
  }

  _onRegisterWithCredentailsSubmitted(
    RegisterWithCredentialsSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(Registering.loading());
    try {
      SignUpResult result =
          await _userRepo.createUser(event.email, event.password);
      if (result.isSignUpComplete) {
        this.add(SignUpCompleted(event.email));
        return;
      }
      if (result.nextStep.signUpStep == 'CONFIRM_SIGN_UP_STEP') {
        emit(ConfirmRegistration.initial(event.email));
      }
    } on UsernameExistsException catch (ex) {
      try {
        await _userRepo.resendSignUpCode(event.email);
        emit(ConfirmRegistration.initial(event.email));
      } on InvalidParameterException catch (ex) {
        emit(Registering.failure(errorMessage: ex.message));
      } catch (ex) {
        emit(Registering.failure(errorMessage: ex.toString()));
      }
    } on InvalidParameterException catch (ex) {
      emit(Registering.failure(errorMessage: ex.message));
    } on AuthException catch (ex) {
      await Sentry.captureException(ex);
      emit(Registering.failure(errorMessage: ex.message));
    } catch (ex) {
      emit(Registering.failure(
          errorMessage: "Er ging iets fout, probeer het opnieuw."));
    }
  }

  _onConfirmCodeSubmitted(
    ConfirmCodeSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit((state as ConfirmRegistration).loading());
    try {
      SignUpResult result = await _userRepo.confirmSignUp(
        (state as ConfirmRegistration).email,
        event.code,
      );
      if (result.isSignUpComplete) {
        this.add(SignUpCompleted((state as ConfirmRegistration).email));
        return;
      }
    } on CodeMismatchException catch (ex) {
      emit((state as ConfirmRegistration).failure(
          "Bevestigingscode onjuist, probeer opnieuw. Indien dat niet werkt, probeer opnieuw aan te melden."));
    } catch (ex) {
      emit((state as ConfirmRegistration).failure(ex.toString()));
    }
  }

  _onSignUpCompleted(
    SignUpCompleted event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      emit(RegisterState(isLoading: false, isSuccess: true, isFailure: false));
    } catch (ex) {
      print(ex);
    }
  }
}
