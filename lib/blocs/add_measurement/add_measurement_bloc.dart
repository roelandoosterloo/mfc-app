import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/measurement.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/utils/validators.dart';

part 'add_measurement_event.dart';
part 'add_measurement_state.dart';

class AddMeasurementBloc
    extends Bloc<AddMeasurementEvent, AddMeasurementState> {
  MeasurementRepository _measureRepo;

  AddMeasurementBloc({required MeasurementRepository measureRepo})
      : _measureRepo = measureRepo,
        super(AddMeasurementState.initial());

  @override
  Stream<AddMeasurementState> mapEventToState(
    AddMeasurementEvent event,
  ) async* {
    if (event is MeasurementDateChanged) {
      yield* _mapDateChangedToState(event.date);
    } else if (event is MeasurementWeightChanged) {
      yield* _mapWeightChangedToState(event.weight);
    } else if (event is MeasurementWaistChanged) {
      yield* _mapWaistChangedToState(event.waist);
    } else if (event is MeasurementHipsChanged) {
      yield* _mapHipsChangedToState(event.hips);
    } else if (event is MeasurementNoteChanged) {
      yield* _mapNoteChangedToState(event.note);
    } else if (event is MeasurementSubmitted) {
      yield* _mapSubmittedToState(event);
    }
  }

  Stream<AddMeasurementState> _mapDateChangedToState(DateTime date) async* {
    yield state.update(isDateValid: true);
  }

  Stream<AddMeasurementState> _mapWeightChangedToState(double weight) async* {
    yield state.update(
      isWeightValid: Validators.isNumberInRange(
        value: weight,
        lower: 0,
        upper: 300,
      ),
    );
  }

  Stream<AddMeasurementState> _mapWaistChangedToState(double waist) async* {
    yield state.update(
      isWaistValid: Validators.isNumberInRange(
        value: waist,
        lower: 0,
      ),
    );
  }

  Stream<AddMeasurementState> _mapHipsChangedToState(double hips) async* {
    yield state.update(
      isHipsValid: Validators.isNumberInRange(
        value: hips,
        lower: 0,
      ),
    );
  }

  Stream<AddMeasurementState> _mapNoteChangedToState(String note) async* {
    yield state.update(
      isWaistValid: true,
    );
  }

  Stream<AddMeasurementState> _mapSubmittedToState(
      MeasurementSubmitted event) async* {
    yield AddMeasurementState.loading();
    try {
      _measureRepo.addMeasurement(Measurement(
        date: event.date,
        weight: event.weight,
        hips: event.hips,
        waist: event.waist,
        note: event.note,
      ));
      yield AddMeasurementState.success();
    } catch (_) {
      yield AddMeasurementState.failure();
    }
  }
}
