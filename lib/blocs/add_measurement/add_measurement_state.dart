part of 'add_measurement_bloc.dart';

class AddMeasurementState extends Equatable {
  final bool isDateValid;
  final bool isWeightValid;
  final bool isHipsValid;
  final bool isWaistValid;
  final bool isNoteValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? error;

  AddMeasurementState({
    required this.isDateValid,
    required this.isWeightValid,
    required this.isHipsValid,
    required this.isWaistValid,
    required this.isNoteValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.error,
  });

  factory AddMeasurementState.initial() {
    return AddMeasurementState(
      isDateValid: true,
      isWeightValid: true,
      isHipsValid: true,
      isWaistValid: true,
      isNoteValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory AddMeasurementState.loading() {
    return AddMeasurementState(
      isDateValid: true,
      isWeightValid: true,
      isHipsValid: true,
      isWaistValid: true,
      isNoteValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory AddMeasurementState.success() {
    return AddMeasurementState(
      isDateValid: true,
      isWeightValid: true,
      isHipsValid: true,
      isWaistValid: true,
      isNoteValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory AddMeasurementState.failure({String? error}) {
    return AddMeasurementState(
      isDateValid: true,
      isWeightValid: true,
      isHipsValid: true,
      isWaistValid: true,
      isNoteValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      error: error,
    );
  }

  AddMeasurementState update({
    bool? isDateValid,
    bool? isWeightValid,
    bool? isHipsValid,
    bool? isWaistValid,
    bool? isNoteValid,
  }) {
    return AddMeasurementState(
      isDateValid: isDateValid ?? this.isDateValid,
      isWeightValid: isWaistValid ?? this.isWaistValid,
      isHipsValid: isHipsValid ?? this.isHipsValid,
      isWaistValid: isWaistValid ?? this.isWaistValid,
      isNoteValid: isNoteValid ?? this.isNoteValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  @override
  List<Object> get props => [
        this.isDateValid,
        this.isWeightValid,
        this.isHipsValid,
        this.isWaistValid,
        this.isNoteValid,
        this.isSubmitting,
        this.isSuccess,
        this.isFailure,
        this.error ?? "",
      ];
}
