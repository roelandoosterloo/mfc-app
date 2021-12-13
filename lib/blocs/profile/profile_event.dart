part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

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
  final DateTime date;

  BirthdateChanged({required this.date});

  @override
  List<Object> get props => [date];
}

class LengthChanged extends ProfileEvent {
  final double length;

  LengthChanged({required this.length});

  @override
  List<Object> get props => [length];
}

class TargetWeightChanged extends ProfileEvent {
  final double weight;

  TargetWeightChanged({required this.weight});

  @override
  List<Object> get props => [weight];
}

class ProfileSubmitted extends ProfileEvent {
  final String firstName;
  final String lastName;
  final DateTime birthDate;
  final double length;
  final double weight;

  ProfileSubmitted({
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.length,
    required this.weight,
  });

  @override
  List<Object> get props => [
        this.firstName,
        this.lastName,
        this.birthDate,
        this.length,
        this.weight,
      ];
}
