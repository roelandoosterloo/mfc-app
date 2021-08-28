import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final AuthUser user;

  AuthenticationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthenticationFailure extends AuthenticationState {}
