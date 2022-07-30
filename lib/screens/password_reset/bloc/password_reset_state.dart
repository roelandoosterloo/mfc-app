part of 'password_reset_bloc.dart';

abstract class PasswordResetState extends Equatable {
  const PasswordResetState();

  @override
  List<Object?> get props => [];
}

class PasswordResetInitial extends PasswordResetState {}

class PasswordResetEmailStep extends PasswordResetState {
  final bool? _emailValid;
  final String? _error;

  PasswordResetEmailStep({bool? emailValid, String? error})
      : _emailValid = emailValid,
        _error = error;

  bool get emailValid {
    return _emailValid ?? false;
  }

  String? get error {
    return _error;
  }

  PasswordResetEmailStep failure(String error) {
    return PasswordResetEmailStep(
      emailValid: _emailValid,
      error: error,
    );
  }

  @override
  List<Object?> get props => [_emailValid, _error];
}

class PasswordResetCodeStep extends PasswordResetState {
  final String email;
  final ResetPasswordResult result;
  final bool? _isPasswordValid;
  final bool? _isCodeValid;
  final bool? _isRepeatValid;
  final String? _error;

  PasswordResetCodeStep(
    this.email,
    this.result, {
    isPasswordValid,
    isCodeValid,
    isRepeatValid,
    error,
  })  : _isCodeValid = isCodeValid,
        _isPasswordValid = isPasswordValid,
        _isRepeatValid = isRepeatValid,
        _error = error;

  bool isValid() {
    return (_isPasswordValid ?? false) &&
        (_isCodeValid ?? false) &&
        (_isRepeatValid ?? false);
  }

  bool get isPasswordValid {
    return _isPasswordValid ?? true;
  }

  bool get isCodeValid {
    return _isCodeValid ?? true;
  }

  bool get isRepeatValid {
    return _isRepeatValid ?? true;
  }

  String? get error {
    return _error;
  }

  PasswordResetCodeStep update({
    bool? isPasswordValid,
    bool? isCodeValid,
    bool? isRepeatValid,
  }) {
    return PasswordResetCodeStep(
      email,
      result,
      isCodeValid: isCodeValid ?? _isCodeValid,
      isPasswordValid: isPasswordValid ?? _isPasswordValid,
      isRepeatValid: isRepeatValid ?? _isRepeatValid,
      error: null,
    );
  }

  PasswordResetCodeStep failure(String error) {
    return PasswordResetCodeStep(
      email,
      result,
      isCodeValid: _isCodeValid,
      isPasswordValid: isPasswordValid,
      isRepeatValid: isRepeatValid,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        email,
        result,
        _isPasswordValid,
        _isCodeValid,
        _isRepeatValid,
        _error,
      ];
}

class PasswordResetRequestedFailure extends PasswordResetState {
  final String error;

  PasswordResetRequestedFailure(this.error);

  @override
  List<Object> get props => [error];
}
