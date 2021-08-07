part of 'module_bloc.dart';

abstract class ModuleState extends Equatable {
  const ModuleState();

  @override
  List<Object> get props => [];
}

class ModuleInitial extends ModuleState {}

class ModuleLoading extends ModuleState {}

class ModuleAvailable extends ModuleState {
  final Module _module;

  ModuleAvailable({required Module module}) : _module = module;

  Module get module => _module;

  @override
  List<Object> get props => [_module];
}

class ModuleLoadingFailed extends ModuleState {
  final String _error;

  ModuleLoadingFailed({String error = ""}) : _error = error;

  String get error => error;

  @override
  List<Object> get props => [_error];
}

class ModuleNotFound extends ModuleState {}
