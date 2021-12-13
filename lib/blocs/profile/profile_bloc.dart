import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/utils/validators.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitialState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdateChanged>(_onBirthdateChanged);
    on<LengthChanged>(_onLengthChanged);
    on<TargetWeightChanged>(_onTargetWeightChanged);
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit((state as EditProfileState).update(isFirstNameValid: true));
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit((state as EditProfileState).update(isLastNameValid: true));
  }

  void _onBirthdateChanged(
    BirthdateChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      (state as EditProfileState).update(
        isBirthDateValid: Validators.isDateInRange(
          value: event.date,
        ),
      ),
    );
  }

  void _onLengthChanged(
    LengthChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      (state as EditProfileState).update(
        isLengthValid: Validators.isNumberInRange(
          value: event.length,
          lower: 100,
          upper: 250,
        ),
      ),
    );
  }

  void _onTargetWeightChanged(
    TargetWeightChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      (state as EditProfileState).update(
        isWeightValid: Validators.isNumberInRange(
          value: event.weight,
          lower: 40,
          upper: 250,
        ),
      ),
    );
  }
}
