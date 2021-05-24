part of 'add_measurement_bloc.dart';

abstract class AddMeasurementEvent extends Equatable {
  const AddMeasurementEvent();

  @override
  List<Object> get props => [];
}

class MeasurementDateChanged extends AddMeasurementEvent {
  final DateTime date;

  MeasurementDateChanged({required this.date});

  @override
  List<Object> get props => [date];
}

class MeasurementWeightChanged extends AddMeasurementEvent {
  final double weight;

  MeasurementWeightChanged({required this.weight});

  @override
  List<Object> get props => [weight];
}

class MeasurementWaistChanged extends AddMeasurementEvent {
  final double waist;

  MeasurementWaistChanged({required this.waist});

  @override
  List<Object> get props => [waist];
}

class MeasurementHipsChanged extends AddMeasurementEvent {
  final double hips;

  MeasurementHipsChanged({required this.hips});

  @override
  List<Object> get props => [hips];
}

class MeasurementNoteChanged extends AddMeasurementEvent {
  final String note;

  MeasurementNoteChanged({required this.note});

  @override
  List<Object> get props => [note];
}

class MeasurementSubmitted extends AddMeasurementEvent {
  final DateTime date;
  final double weight;
  final double hips;
  final double waist;
  final String note;

  MeasurementSubmitted({
    required this.date,
    required this.weight,
    required this.hips,
    required this.waist,
    required this.note,
  });

  @override
  List<Object> get props => [
        date,
        weight,
        hips,
        waist,
        note,
      ];
}
