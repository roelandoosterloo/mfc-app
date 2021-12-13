import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/measurement.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';

part 'measurement_event.dart';
part 'measurement_state.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final MeasurementRepository _measureRepo;

  MeasurementBloc({required MeasurementRepository measurementRepo})
      : _measureRepo = measurementRepo,
        super(MeasurementInitial()) {
    on<MeasurementsDataRequested>(_onRequestMeasurements);
  }

  void _onRequestMeasurements(
    MeasurementsDataRequested event,
    Emitter<MeasurementState> emit,
  ) async {
    emit(MeasurementLoading());
    try {
      List<Measurement> measurements = await _measureRepo.listMeasurements();
      emit(MeasurementsAvailable(measurements: measurements));
    } catch (ex) {
      emit(MeasurementsFailed(error: ex.toString()));
    }
  }
}
