part of 'register_bloc.dart';

class RegisterState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String? error;

  const RegisterState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, error];
}

class Registering extends RegisterState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isRepeatValid;

  Registering({
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isRepeatValid,
    required bool isLoading,
    required bool isSuccess,
    required bool isFailure,
    String? error,
  }) : super(
            isLoading: isLoading,
            isFailure: isFailure,
            isSuccess: isSuccess,
            error: error);

  factory Registering.initial() {
    return Registering(
      isEmailValid: true,
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory Registering.loading() {
    return Registering(
      isEmailValid: true,
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory Registering.success() {
    return Registering(
      isEmailValid: true,
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: false,
      isSuccess: true,
      isFailure: false,
    );
  }
  factory Registering.failure({String? errorMessage}) {
    return Registering(
      isEmailValid: true,
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: false,
      isSuccess: false,
      isFailure: true,
      error: errorMessage ?? "",
    );
  }

  Registering update({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isRepeatValid,
  }) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isRepeatValid: isRepeatValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
    );
  }

  Registering copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isRepeatValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return Registering(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isRepeatValid: isRepeatValid ?? this.isRepeatValid,
      isLoading: isSubmitting ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  bool canSubmit() {
    return isEmailValid && isPasswordValid && isRepeatValid && !isLoading;
  }

  @override
  List<Object?> get props =>
      [...super.props, isEmailValid, isPasswordValid, isRepeatValid];
}

class ConfirmRegistration extends RegisterState {
  final String email;

  ConfirmRegistration(
      {required bool isLoading,
      required bool isSuccess,
      required bool isFailure,
      required this.email,
      String? error})
      : super(
          isLoading: isLoading,
          isSuccess: isSuccess,
          isFailure: isFailure,
          error: error,
        );

  factory ConfirmRegistration.initial(String email) {
    return ConfirmRegistration(
      email: email,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  ConfirmRegistration loading() {
    return copyWith(
      isLoading: true,
      isFailure: false,
      isSuccess: false,
      error: '',
    );
  }

  ConfirmRegistration failure(String error) {
    return copyWith(
      isLoading: false,
      isFailure: true,
      isSuccess: false,
      error: error,
    );
  }

  ConfirmRegistration success() {
    return copyWith(
      isLoading: false,
      isFailure: false,
      isSuccess: true,
      error: '',
    );
  }

  ConfirmRegistration copyWith({
    String? email,
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? error,
  }) {
    return ConfirmRegistration(
      email: email ?? this.email,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [...super.props, email];
}
