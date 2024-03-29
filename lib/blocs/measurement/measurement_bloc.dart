import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/Measurement.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../models/Profile.dart';

part 'measurement_event.dart';
part 'measurement_state.dart';

class MeasurementBloc extends Bloc<MeasurementEvent, MeasurementState> {
  final MeasurementRepository _measureRepo;
  final UserRepository _userRepo;
  final ProfileRepository _profileRepo;

  MeasurementBloc({
    required MeasurementRepository measurementRepo,
    required UserRepository userRepo,
    required ProfileRepository profileRepo,
  })  : _measureRepo = measurementRepo,
        _userRepo = userRepo,
        _profileRepo = profileRepo,
        super(MeasurementInitial()) {
    on<MeasurementsDataRequested>(_onRequestMeasurements);
    on<MeasurementDeleteClicked>(_onMeasurementDeleteClicked);
  }

  void _onRequestMeasurements(
    MeasurementsDataRequested _,
    Emitter<MeasurementState> emit,
  ) async {
    emit(MeasurementLoading());
    try {
      String username = await _userRepo.getUsername();
      Profile p = await _profileRepo.getProfile(username);
      List<Measurement> measurements = await _measureRepo.listMeasurements();
      measurements.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      if (measurements.isEmpty) {
        emit(NoMeasurementsAvailable());
      } else {
        emit(MeasurementsAvailable(measurements: measurements, profile: p));
      }
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      emit(MeasurementsFailed(error: e.toString()));
    }
  }

  void _onMeasurementDeleteClicked(
    MeasurementDeleteClicked event,
    Emitter<MeasurementState> emit,
  ) async {
    try {
      _measureRepo.removeMeasurement(event.id);
      this.add(new MeasurementsDataRequested());
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
    }
  }
}
