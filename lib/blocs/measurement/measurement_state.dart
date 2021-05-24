part of 'measurement_bloc.dart';

abstract class MeasurementState extends Equatable {
  const MeasurementState();

  @override
  List<Object> get props => [];
}

class MeasurementInitial extends MeasurementState {}

class MeasurementLoading extends MeasurementState {}

class MeasurementsAvailable extends MeasurementState {
  final List<Measurement> _measurements;

  MeasurementsAvailable({required List<Measurement> measurements})
      : _measurements = measurements;

  List<Measurement> get measurements => _measurements;

  @override
  List<Object> get props => [_measurements];
}

class MeasurementsFailed extends MeasurementState {
  final String _error;

  MeasurementsFailed({String error = ""}) : _error = error;

  String? get error => _error;

  @override
  List<Object> get props => [_error];
}
