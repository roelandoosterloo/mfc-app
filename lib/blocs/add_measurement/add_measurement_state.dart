part of 'add_measurement_bloc.dart';

enum FieldState { valid, invalid, pristine }

class AddMeasurementState extends Equatable {
  final FieldState isDateValid;
  final FieldState isWeightValid;
  final FieldState isNoteValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final String? error;

  AddMeasurementState({
    required this.isDateValid,
    required this.isWeightValid,
    required this.isNoteValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.error,
  });

  factory AddMeasurementState.initial() {
    return AddMeasurementState(
      isDateValid: FieldState.pristine,
      isWeightValid: FieldState.pristine,
      isNoteValid: FieldState.pristine,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory AddMeasurementState.loading() {
    return AddMeasurementState(
      isDateValid: FieldState.pristine,
      isWeightValid: FieldState.pristine,
      isNoteValid: FieldState.pristine,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }
  factory AddMeasurementState.success() {
    return AddMeasurementState(
      isDateValid: FieldState.pristine,
      isWeightValid: FieldState.pristine,
      isNoteValid: FieldState.pristine,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory AddMeasurementState.failure({String? error}) {
    return AddMeasurementState(
      isDateValid: FieldState.pristine,
      isWeightValid: FieldState.pristine,
      isNoteValid: FieldState.pristine,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      error: error,
    );
  }

  AddMeasurementState update({
    FieldState? isDateValid,
    FieldState? isWeightValid,
    FieldState? isNoteValid,
  }) {
    return AddMeasurementState(
      isDateValid: isDateValid ?? this.isDateValid,
      isWeightValid: isWeightValid ?? this.isWeightValid,
      isNoteValid: isNoteValid ?? this.isNoteValid,
      isSubmitting: isSubmitting,
      isSuccess: isSuccess,
      isFailure: isFailure,
    );
  }

  bool isValid() {
    return isDateValid == FieldState.valid &&
        isWeightValid == FieldState.valid &&
        (isNoteValid == FieldState.valid || isNoteValid == FieldState.pristine);
  }

  @override
  List<Object> get props => [
        this.isDateValid,
        this.isWeightValid,
        this.isNoteValid,
        this.isSubmitting,
        this.isSuccess,
        this.isFailure,
        this.error ?? "",
      ];
}
