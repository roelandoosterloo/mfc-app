part of 'measurement_bloc.dart';

abstract class MeasurementEvent extends Equatable {
  const MeasurementEvent();

  @override
  List<Object> get props => [];
}

class MeasurementsDataRequested extends MeasurementEvent {}

class MeasurementsFound extends MeasurementEvent {
  final List<Measurement> measurements;

  MeasurementsFound(this.measurements);
}

class MeasurementLoadingFailed extends MeasurementEvent {
  final String error;

  MeasurementLoadingFailed(this.error);
}
