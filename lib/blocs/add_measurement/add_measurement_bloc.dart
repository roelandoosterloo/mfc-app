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
        super(AddMeasurementState.initial()) {
    on<MeasurementDateChanged>(_onDateChanged);
    on<MeasurementWeightChanged>(_onWeightChanged);
    on<MeasurementNoteChanged>(_onNoteChanged);
    on<MeasurementSubmitted>(_onSubmitted);
  }

  void _onDateChanged(
    MeasurementDateChanged event,
    Emitter<AddMeasurementState> emit,
  ) {
    try {
      DateTime date = DateTime.parse(event.date);
      emit(state.update(isDateValid: true));
    } catch (ex) {
      emit(state.update(isDateValid: false));
    }
  }

  void _onWeightChanged(
    MeasurementWeightChanged event,
    Emitter<AddMeasurementState> emit,
  ) {
    try {
      double weight = double.parse(event.weight);
      emit(
        state.update(
          isWeightValid: Validators.isNumberInRange(
            value: weight,
            lower: 0,
            upper: 300,
          ),
        ),
      );
    } catch (ex) {
      emit(state.update(isWeightValid: false));
    }
  }

  void _onNoteChanged(
    MeasurementNoteChanged event,
    Emitter<AddMeasurementState> emit,
  ) {
    emit(
      state.update(
        isNoteValid: true,
      ),
    );
  }

  void _onSubmitted(
    MeasurementSubmitted event,
    Emitter<AddMeasurementState> emit,
  ) {
    emit(AddMeasurementState.loading());
    try {
      _measureRepo.addMeasurement(Measurement(
        date: event.date,
        weight: event.weight,
        note: event.note,
      ));
      emit(AddMeasurementState.success());
    } catch (_) {
      emit(AddMeasurementState.failure());
    }
  }
}
