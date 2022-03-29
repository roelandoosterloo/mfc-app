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
  final Profile _profile;

  MeasurementsAvailable({
    required List<Measurement> measurements,
    required Profile profile,
  })  : _measurements = measurements,
        _profile = profile;

  List<Measurement> get measurements => _measurements;
  Profile get profile => _profile;

  double? get currentWeight {
    if (_measurements.isEmpty) {
      return null;
    }
    return _measurements.last.weight;
  }

  double? get totalWeightLost {
    if (_measurements.isEmpty) {
      return null;
    }
    double first = _measurements.first.weight;
    double last = _measurements.last.weight;

    return first - last;
  }

  double? get bmi {
    if (profile.length == null) return null;
    if (currentWeight == null) return null;
    return currentWeight! / profile.length! / profile.length!;
  }

  @override
  List<Object> get props => [_measurements, profile];
}

class NoMeasurementsAvailable extends MeasurementState {}

class MeasurementsFailed extends MeasurementState {
  final String _error;

  MeasurementsFailed({String error = ""}) : _error = error;

  String? get error => _error;

  @override
  List<Object> get props => [_error];
}
