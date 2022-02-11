import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String? error;

  const LoginState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.error,
  });

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, error];
}

class LoggingIn extends LoginState {
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool needsConfirmation;
  final AuthNextSignInStep? nextStep;

  LoggingIn({
    required this.isEmailValid,
    required this.isPasswordValid,
    required bool isSubmitting,
    required bool isSuccess,
    required bool isFailure,
    required this.needsConfirmation,
    String? error,
    this.nextStep,
  }) : super(
          isLoading: isSubmitting,
          isFailure: isFailure,
          isSuccess: isSuccess,
          error: error,
        );

  factory LoggingIn.initial() {
    return LoggingIn(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      needsConfirmation: false,
    );
  }
  factory LoggingIn.loading() {
    return LoggingIn(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      needsConfirmation: false,
    );
  }
  factory LoggingIn.success() {
    return LoggingIn(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      needsConfirmation: false,
    );
  }
  factory LoggingIn.failure({required String error}) {
    return LoggingIn(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      needsConfirmation: false,
      error: error,
    );
  }
  factory LoggingIn.confirmationNeeded(AuthNextSignInStep? nextStep) {
    return LoggingIn(
      isEmailValid: true,
      isPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      needsConfirmation: true,
      nextStep: nextStep,
    );
  }

  LoggingIn update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false,
      needsConfirmation: false,
    );
  }

  LoggingIn copyWith({
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? needsConfirmation,
    String? error,
  }) {
    return LoggingIn(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting: isSubmitting ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      needsConfirmation: needsConfirmation ?? this.needsConfirmation,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
        isEmailValid,
        isPasswordValid,
        isLoading,
        isSuccess,
        isFailure,
        needsConfirmation,
        error
      ];
}

class SetupPassword extends LoginState {
  final bool isPasswordValid;
  final bool isRepeatValid;

  SetupPassword({
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
          error: error,
        );

  factory SetupPassword.initial() {
    return SetupPassword(
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SetupPassword.loading() {
    return SetupPassword(
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory SetupPassword.failure({required String error}) {
    return SetupPassword(
      isPasswordValid: true,
      isRepeatValid: true,
      isLoading: false,
      isSuccess: false,
      isFailure: true,
      error: error,
    );
  }

  SetupPassword copyWith({
    isPasswordValid,
    isRepeatValid,
    isLoading,
    isSuccess,
    isFailure,
  }) {
    return SetupPassword(
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isRepeatValid: isRepeatValid ?? this.isRepeatValid,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  @override
  List<Object?> get props => [
        isPasswordValid,
        isRepeatValid,
        isLoading,
        isSuccess,
        isFailure,
        error,
      ];
}
