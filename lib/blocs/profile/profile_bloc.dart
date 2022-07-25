import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/utils/parser.dart';
import 'package:mfc_app/utils/validators.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _profileRepo;

  ProfileBloc({required ProfileRepository profileRepo})
      : _profileRepo = profileRepo,
        super(ProfileInitialState()) {
    on<ProfileOpened>(_onProfileOpened);
    on<ProfileLoadingDone>(_onProfileLoadingDone);
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthdateChanged>(_onBirthdateChanged);
    on<LengthChanged>(_onLengthChanged);
    on<TargetWeightChanged>(_onTargetWeightChanged);
    on<ProfileSubmitted>(_onProfileSubmitted);
  }

  void _onProfileOpened(
    ProfileOpened event,
    Emitter<ProfileState> emit,
  ) async {
    Profile profile = await _profileRepo.getProfile(event.cognitoId);
    emit(EditProfileState.initial(profile));
  }

  void _onProfileLoadingDone(
    ProfileLoadingDone event,
    Emitter<ProfileState> emit,
  ) {
    emit((state as EditProfileState).update(loaded: true));
  }

  void _onFirstNameChanged(
    FirstNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      (state as EditProfileState).update(
        isFirstNameValid: Validators.isNotEmpty(event.name),
      ),
    );
  }

  void _onLastNameChanged(
    LastNameChanged event,
    Emitter<ProfileState> emit,
  ) {
    emit(
      (state as EditProfileState).update(
        isLastNameValid: Validators.isNotEmpty(event.name),
      ),
    );
  }

  void _onBirthdateChanged(
    BirthdateChanged event,
    Emitter<ProfileState> emit,
  ) {
    if (event.date.isEmpty) {
      emit((state as EditProfileState).update(isBirthDateValid: true));
      return;
    }
    try {
      DateTime? date = Parser.readDateLocal(event.date);
      if (date == null)
        return emit((state as EditProfileState).update(isBirthDateValid: true));
      emit(
        (state as EditProfileState).update(
          isBirthDateValid: Validators.isDateInRange(
            lower: DateTime(1940, 1, 1),
            value: date,
          ),
        ),
      );
    } catch (ex) {
      emit((state as EditProfileState).update(isBirthDateValid: false));
    }
  }

  void _onLengthChanged(
    LengthChanged event,
    Emitter<ProfileState> emit,
  ) {
    double? length = Parser.readDouble(event.length);
    if (length == null) {
      emit((state as EditProfileState).update(isLengthValid: true));
      return;
    }
    emit(
      (state as EditProfileState).update(
        isLengthValid: Validators.isNumberInRange(
          value: length,
          lower: 1.00,
          upper: 2.50,
        ),
      ),
    );
  }

  void _onTargetWeightChanged(
    TargetWeightChanged event,
    Emitter<ProfileState> emit,
  ) {
    double? weight = Parser.readDouble(event.weight);
    if (weight == null) {
      emit((state as EditProfileState).update(isWeightValid: true));
      return;
    }
    emit(
      (state as EditProfileState).update(
        isWeightValid: Validators.isNumberInRange(
          value: weight,
          lower: 40,
          upper: 250,
        ),
      ),
    );
  }

  void _onProfileSubmitted(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    Profile? profile = state.profile;
    if (profile == null) {
      emit(ProfileFailureState(state, "Could not find profile"));
      return;
    }

    if (!state.isValid()) {
      emit((state as EditProfileState));
      return;
    }

    try {
      DateTime? birthDate = Parser.readDateLocal(event.birthDate ?? "");
      double? length = Parser.readDouble(event.length);
      double? targetWeight = Parser.readDouble(event.targetWeight);

      bool success = await _profileRepo.submitProfile(profile.update(
        firstName: event.firstName,
        lastName: event.lastName,
        birthDate: birthDate,
        length: length,
        targetWeight: targetWeight,
      ));
      if (success) {
        emit(ProfileSuccessState(state));
      } else {
        emit(ProfileFailureState(state, "Something went wrong"));
      }
    } catch (ex, stack) {
      await Sentry.captureException(ex, stackTrace: stack);
      emit(ProfileFailureState(state, "Something went wrong"));
    }
  }
}
