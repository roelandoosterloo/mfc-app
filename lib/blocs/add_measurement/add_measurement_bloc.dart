import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/measurement.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/parser.dart';
import 'package:mfc_app/utils/validators.dart';

part 'add_measurement_event.dart';
part 'add_measurement_state.dart';

class AddMeasurementBloc
    extends Bloc<AddMeasurementEvent, AddMeasurementState> {
  MeasurementRepository _measureRepo;
  UserRepository _userRepo;

  AddMeasurementBloc({
    required MeasurementRepository measureRepo,
    required UserRepository userRepo,
  })  : _measureRepo = measureRepo,
        _userRepo = userRepo,
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
      Parser.readDateLocal(event.date);
      emit(state.update(isDateValid: FieldState.valid));
    } catch (ex) {
      emit(state.update(isDateValid: FieldState.invalid));
    }
  }

  void _onWeightChanged(
    MeasurementWeightChanged event,
    Emitter<AddMeasurementState> emit,
  ) {
    double? weight = Parser.readDouble(event.weight);
    if (weight == null) {
      return emit(state.update(isWeightValid: FieldState.invalid));
    }
    bool weightValid = Validators.isNumberInRange(
      value: weight,
      lower: 0,
      upper: 300,
    );
    emit(
      state.update(
        isWeightValid: weightValid ? FieldState.valid : FieldState.invalid,
      ),
    );
  }

  void _onNoteChanged(
    MeasurementNoteChanged event,
    Emitter<AddMeasurementState> emit,
  ) {
    emit(
      state.update(
        isNoteValid: FieldState.valid,
      ),
    );
  }

  void _onSubmitted(
    MeasurementSubmitted event,
    Emitter<AddMeasurementState> emit,
  ) async {
    emit(AddMeasurementState.loading());
    try {
      String userName = await _userRepo.getUsername();
      await _measureRepo.addMeasurement(
          Measurement(
            date: event.date,
            weight: event.weight,
            note: event.note,
          ),
          userName);
      emit(AddMeasurementState.success());
    } catch (_) {
      emit(AddMeasurementState.failure());
    }
  }
}
