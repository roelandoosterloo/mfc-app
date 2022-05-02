part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  RegisterEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class RepeatPasswordChanged extends RegisterEvent {
  final String password;
  final String repeat;

  RepeatPasswordChanged({
    required this.password,
    required this.repeat,
  });

  @override
  List<Object> get props => [password, repeat];
}

class RegisterWithCredentialsSubmitted extends RegisterEvent {
  final String email;
  final String password;

  RegisterWithCredentialsSubmitted(
      {required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ConfirmCodeSubmitted extends RegisterEvent {
  final String _code;

  ConfirmCodeSubmitted(this._code);

  get code => _code;

  @override
  List<Object> get props => [_code];
}

class SignUpCompleted extends RegisterEvent {
  final String _email;

  SignUpCompleted(this._email);

  String get email => _email;

  @override
  List<Object> get props => [_email];
}
