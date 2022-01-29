part of 'add_measurement_bloc.dart';

abstract class AddMeasurementEvent extends Equatable {
  const AddMeasurementEvent();

  @override
  List<Object> get props => [];
}

class MeasurementDateChanged extends AddMeasurementEvent {
  final String date;

  MeasurementDateChanged({required this.date});

  @override
  List<Object> get props => [date];
}

class MeasurementWeightChanged extends AddMeasurementEvent {
  final String weight;

  MeasurementWeightChanged({required this.weight});

  @override
  List<Object> get props => [weight];
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
  final String note;

  MeasurementSubmitted({
    required this.date,
    required this.weight,
    required this.note,
  });

  @override
  List<Object> get props => [
        date,
        weight,
        note,
      ];
}
