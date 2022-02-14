part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object?> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetEmailStep extends PasswordResetState {
  final bool? _emailValid;

  PasswordResetEmailStep({bool? emailValid}) : _emailValid = emailValid;

  bool get emailValid {
    return _emailValid ?? false;
  }

  @override
  List<Object?> get props => [_emailValid];
}

class PasswordResetCodeStep extends PasswordResetState {
  final String email;
  final ResetPasswordResult result;
  final bool? _isPasswordValid;
  final bool? _isCodeValid;

  PasswordResetCodeStep(
    this.email,
    this.result, {
    isPasswordValid,
    isCodeValid,
  })  : _isCodeValid = isCodeValid,
        _isPasswordValid = isPasswordValid;

  bool isValid() {
    return (_isPasswordValid ?? false) && (_isCodeValid ?? false);
  }

  bool get isPasswordValid {
    return _isPasswordValid ?? true;
  }

  bool get isCodeValid {
    return _isCodeValid ?? true;
  }

  PasswordResetCodeStep update({
    bool? isPasswordValid,
    bool? isCodeValid,
  }) {
    return PasswordResetCodeStep(
      email,
      result,
      isCodeValid: isCodeValid ?? _isCodeValid,
      isPasswordValid: isPasswordValid ?? _isPasswordValid,
    );
  }

  @override
  List<Object?> get props => [email, result, _isPasswordValid, _isCodeValid];
}

class PasswordResetRequestedFailure extends PasswordResetState {
  final String error;

  PasswordResetRequestedFailure(this.error);

  @override
  List<Object> get props => [error];
}
