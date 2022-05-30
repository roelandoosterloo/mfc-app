import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/measurement.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';

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
      Stream<List<Measurement>> measurementsStream =
          _measureRepo.listMeasurements();
      await measurementsStream.forEach((measurements) {
        if (measurements.isEmpty) {
          emit(NoMeasurementsAvailable());
        } else {
          emit(MeasurementsAvailable(measurements: measurements, profile: p));
        }
      });
    } catch (ex) {
      print(ex);
      emit(MeasurementsFailed(error: ex.toString()));
    }
  }

  void _onMeasurementDeleteClicked(
    MeasurementDeleteClicked event,
    Emitter<MeasurementState> emit,
  ) async {
    try {
      _measureRepo.removeMeasurement(event.id);
      this.add(new MeasurementsDataRequested());
    } catch (ex) {
      print(ex);
    }
  }
}
