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
    // refresh();
  }

  dispose() {}

  // refresh() {
  //   _measureRepo.refresh().listen((data) {
  //     add(MeasurementsFound(data));
  //   }, onError: (error) {
  //     add(MeasurementLoadingFailed(error));
  //   });
  // }

  @override
  Stream<MeasurementState> mapEventToState(MeasurementEvent event) async* {
    if (event is MeasurementsDataRequested) {
      yield* _mapDataRequestedToState();
    } else if (event is MeasurementsFound) {
      yield* _mapFoundToState(event.measurements);
    } else if (event is MeasurementLoadingFailed) {
      yield* _mapLoadingFailedToState(event.error);
    }
  }

  Stream<MeasurementState> _mapDataRequestedToState() async* {
    yield MeasurementLoading();
    List<Measurement> measurements = await _measureRepo.listMeasurements();
    add(MeasurementsFound(measurements));
  }

  Stream<MeasurementState> _mapFoundToState(
      List<Measurement> measurement) async* {
    yield MeasurementsAvailable(measurements: measurement);
  }

  Stream<MeasurementState> _mapLoadingFailedToState(String error) async* {
    yield MeasurementsFailed(error: error);
  }
}
