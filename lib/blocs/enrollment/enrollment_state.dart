part of 'enrollment_bloc.dart';

class EnrollmentState extends Equatable {
  final bool loading;
  final String? errorMessage;
  final List<Enrollment> enrollments;
  final Enrollment? selected;

  const EnrollmentState({
    this.loading = false,
    this.errorMessage,
    this.enrollments = const <Enrollment>[],
    this.selected,
  });

  EnrollmentState copyWith({
    bool? loading,
    String? errorMessage,
    List<Enrollment>? enrollments,
    Enrollment? selected,
  }) {
    return EnrollmentState(
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      enrollments: enrollments ?? this.enrollments,
      selected: selected ?? this.selected,
    );
  }

  @override
  List<Object> get props => [
        loading,
        errorMessage ?? "NA",
        enrollments,
        selected ?? "NA",
      ];
}

class EnrollmentInitial extends EnrollmentState {}
