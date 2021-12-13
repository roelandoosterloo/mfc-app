part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  final bool isFirstNameValid;
  final bool isLastNameValid;
  final bool isBirthDateValid;
  final bool isLengthValid;
  final bool isWeightValid;

  const ProfileState({
    required this.isFirstNameValid,
    required this.isLastNameValid,
    required this.isBirthDateValid,
    required this.isLengthValid,
    required this.isWeightValid,
  });

  @override
  List<Object> get props => [];
}

class ProfileInitialState extends ProfileState {
  ProfileInitialState()
      : super(
          isFirstNameValid: true,
          isLastNameValid: true,
          isBirthDateValid: true,
          isLengthValid: true,
          isWeightValid: true,
        );
}

class EditProfileState extends ProfileState {
  EditProfileState({
    required bool isFirstNameValid,
    required bool isLastNameValid,
    required bool isBirthDateValid,
    required bool isLengthValid,
    required bool isWeightValid,
  }) : super(
          isFirstNameValid: isFirstNameValid,
          isLastNameValid: isLastNameValid,
          isBirthDateValid: isBirthDateValid,
          isLengthValid: isLengthValid,
          isWeightValid: isWeightValid,
        );

  factory EditProfileState.initial() {
    return EditProfileState(
      isFirstNameValid: true,
      isLastNameValid: true,
      isBirthDateValid: true,
      isLengthValid: true,
      isWeightValid: true,
    );
  }

  EditProfileState update({
    bool? isFirstNameValid,
    bool? isLastNameValid,
    bool? isBirthDateValid,
    bool? isLengthValid,
    bool? isWeightValid,
  }) {
    return EditProfileState(
      isFirstNameValid: isFirstNameValid ?? this.isFirstNameValid,
      isLastNameValid: isLastNameValid ?? this.isLastNameValid,
      isBirthDateValid: isBirthDateValid ?? this.isBirthDateValid,
      isLengthValid: isLengthValid ?? this.isLengthValid,
      isWeightValid: isWeightValid ?? this.isWeightValid,
    );
  }

  @override
  List<Object> get props => [
        isFirstNameValid,
        isLastNameValid,
        isBirthDateValid,
        isLengthValid,
        isWeightValid,
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
        );
}

class ProfileSuccessState extends ProfileState {
  ProfileSuccessState(ProfileState prev)
      : super(
          isFirstNameValid: prev.isFirstNameValid,
          isLastNameValid: prev.isLastNameValid,
          isBirthDateValid: prev.isBirthDateValid,
          isLengthValid: prev.isLengthValid,
          isWeightValid: prev.isWeightValid,
        );
}

class ProfileFailureState extends ProfileState {
  final String error;

  ProfileFailureState(ProfileState prev, this.error)
      : super(
          isFirstNameValid: prev.isFirstNameValid,
          isLastNameValid: prev.isLastNameValid,
          isBirthDateValid: prev.isBirthDateValid,
          isLengthValid: prev.isLengthValid,
          isWeightValid: prev.isWeightValid,
        );
}
