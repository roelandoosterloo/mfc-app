class LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String error;

  LoginState({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.error = "",
  });

  factory LoginState.initial() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.loading() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory LoginState.success() {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory LoginState.failure({String? error}) {
    return LoginState(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      error: error ?? "",
    );
  }

  LoginState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  LoginState copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    String? error,
  }) {
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }
}
