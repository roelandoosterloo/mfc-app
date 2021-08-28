import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithCredentialsSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginWithCredentialsSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class LoginConfirmationSubmitted extends LoginEvent {
  final String code;

  LoginConfirmationSubmitted({required this.code});

  @override
  List<Object> get props => [code];
}
