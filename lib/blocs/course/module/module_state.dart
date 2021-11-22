part of 'module_bloc.dart';

abstract class ModuleProgressState extends Equatable {
  const ModuleProgressState();

  @override
  List<Object> get props => [];
}

class ModuleProgressInitial extends ModuleProgressState {}

class ModuleProgressLoading extends ModuleProgressState {}

class ModuleProgressAvailable extends ModuleProgressState {
  final ModuleProgress _moduleProgress;

  ModuleProgressAvailable({required ModuleProgress moduleprogress})
      : _moduleProgress = moduleprogress;

  ModuleProgress get moduleprogress => _moduleProgress;

  @override
  List<Object> get props => [_moduleProgress];
}

class ModuleProgressLoadingFailed extends ModuleProgressState {
  final String _error;

  ModuleProgressLoadingFailed({String error = ""}) : _error = error;

  String get error => error;

  @override
  List<Object> get props => [_error];
}

class ModuleProgressNotFound extends ModuleProgressState {}
