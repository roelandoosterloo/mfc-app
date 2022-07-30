part of 'password_reset_bloc.dart';

abstract class PasswordResetEvent extends Equatable {
  const PasswordResetEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends PasswordResetEvent {
  final String email;

  EmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class CodeChanged extends PasswordResetEvent {
  final String code;

  CodeChanged({required this.code});

  @override
  List<Object> get props => [code];
}

class PasswordChanged extends PasswordResetEvent {
  final String password;

  PasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class PasswordRepeatChanged extends PasswordResetEvent {
  final String password;
  final String repeat;

  PasswordRepeatChanged({required this.password, required this.repeat});

  List<Object> get props => [password, repeat];
}

class RequestSubmitted extends PasswordResetEvent {
  final String email;

  RequestSubmitted({required this.email});

  @override
  List<Object> get props => [email];
}

class ResetConfirmed extends PasswordResetEvent {
  final String code;
  final String password;

  ResetConfirmed(this.code, this.password);

  @override
  List<Object> get props => [code, password];
}
