part of 'module_bloc.dart';

abstract class ModuleEvent extends Equatable {
  const ModuleEvent();

  @override
  List<Object> get props => [];
}

class ModuleSelected extends ModuleEvent {
  final String _courseId;
  final String _moduleId;

  ModuleSelected(this._courseId, this._moduleId);

  String get moduleId => _moduleId;
  String get courseId => _courseId;

  @override
  List<Object> get props => [_courseId, _moduleId];
}

class ModuleFound extends ModuleEvent {
  final Module _module;

  ModuleFound(this._module);

  Module get module => _module;

  @override
  List<Object> get props => [_module];
}
