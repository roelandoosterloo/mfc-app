part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isBirthDateValid;
  final bool isLengthValid;
  final bool isWeightValid;
  final Profile? profile;

  const ProfileState({
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.isBirthDateValid,
    required this.isLengthValid,
    required this.isWeightValid,
    this.profile,
  });

  bool isValid() {
    return isFirstNameValid &&
        isLastNameValid &&
        isBirthDateValid &&
        isLengthValid &&
        isWeightValid;
  }

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {
  ProfileInitialState({Profile? profile})
      : super(
          isFirstNameValid: true,
          isLastNameValid: true,
          isBirthDateValid: true,
          isLengthValid: true,
          isWeightValid: true,
          profile: profile,
        );
}

class EditProfileState extends ProfileState {
  final bool loaded;

  EditProfileState({
    required bool isFirstNameValid,
    required bool isLastNameValid,
    required bool isBirthDateValid,
    required bool isLengthValid,
    required bool isWeightValid,
    Profile? profile,
    bool? loaded,
  })  : loaded = loaded ?? false,
        super(
          isFirstNameValid: isFirstNameValid,
          isLastNameValid: isLastNameValid,
          isBirthDateValid: isBirthDateValid,
          isLengthValid: isLengthValid,
          isWeightValid: isWeightValid,
          profile: profile,
        );

  factory EditProfileState.initial(Profile p) {
    return EditProfileState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isBirthDateValid: true,
      isLengthValid: true,
      isWeightValid: true,
      loaded: false,
      profile: p,
    );
  }

  EditProfileState update({
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isBirthDateValid,
    bool? isLengthValid,
    bool? isWeightValid,
    Profile? profile,
    bool? loaded,
  }) {
    return EditProfileState(
        isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
        isLastNameValid: isLastNameValid ?? this.isLastNameValid,
        isBirthDateValid: isBirthDateValid ?? this.isBirthDateValid,
        isLengthValid: isLengthValid ?? this.isLengthValid,
        isWeightValid: isWeightValid ?? this.isWeightValid,
        profile: profile ?? this.profile,
        loaded: loaded ?? this.loaded);
  }

  @override
  List<Object> get props => [
        isFirstNameValid,
        isLastNameValid,
        isBirthDateValid,
        isLengthValid,
        isWeightValid,
        loaded,
        profile ?? "no-profile"
      ];
}

class SubmittingProfileState extends ProfileState {
  SubmittingProfileState(ProfileState prev)
      : super(
          isFirstNameValid: prev.isFirstNameValid,
          isLastNameValid: prev.isLastNameValid,
          isBirthDateValid: prev.isBirthDateValid,
          isLengthValid: prev.isLengthValid,
          isWeightValid: prev.isWeightValid,
          profile: prev.profile,
        );
}

class ProfileSuccessState extends EditProfileState {
  ProfileSuccessState(ProfileState prev)
      : super(
          isFirstNameValid: prev.isFirstNameValid,
          isLastNameValid: prev.isLastNameValid,
          isBirthDateValid: prev.isBirthDateValid,
          isLengthValid: prev.isLengthValid,
          isWeightValid: prev.isWeightValid,
          profile: prev.profile,
          loaded: true,
        );
}

class ProfileFailureState extends EditProfileState {
  final String error;

  ProfileFailureState(ProfileState prev, this.error)
      : super(
          isFirstNameValid: prev.isFirstNameValid,
          isLastNameValid: prev.isLastNameValid,
          isBirthDateValid: prev.isBirthDateValid,
          isLengthValid: prev.isLengthValid,
          isWeightValid: prev.isWeightValid,
          profile: prev.profile,
          loaded: true,
        );
}
