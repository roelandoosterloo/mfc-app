part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileOpened extends ProfileEvent {
  final String cognitoId;

  ProfileOpened({required this.cognitoId});

  @override
  List<Object> get props => [cognitoId];
}

class ProfileLoadingDone extends ProfileEvent {}

class FirstNameChanged extends ProfileEvent {
  final String name;

  FirstNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class LastNameChanged extends ProfileEvent {
  final String name;

  LastNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class BirthdateChanged extends ProfileEvent {
  final String date;

  BirthdateChanged({required this.date});

  @override
  List<Object> get props => [date];
}

class LengthChanged extends ProfileEvent {
  final String length;

  LengthChanged({required this.length});

  @override
  List<Object> get props => [length];
}

class TargetWeightChanged extends ProfileEvent {
  final String weight;

  TargetWeightChanged({required this.weight});

  @override
  List<Object> get props => [weight];
}

class ProfileSubmitted extends ProfileEvent {
  final String? firstName;
  final String? lastName;
  final String? birthDate;
  final String? length;
  final String? targetWeight;

  ProfileSubmitted(
      {String? firstName,
      String? lastName,
      String? birthDate,
      String? length,
      String? targetWeight})
      : firstName = firstName,
        lastName = lastName,
        birthDate = birthDate,
        length = length,
        targetWeight = targetWeight;

  List<Object> get props => [
        firstName ?? "",
        lastName ?? "",
        birthDate ?? "",
        length ?? "",
        targetWeight ?? ""
      ];
}
