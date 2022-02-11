part of 'module_bloc.dart';

abstract class ModuleProgressEvent extends Equatable {
  const ModuleProgressEvent();

  @override
  List<Object?> get props => [];
}

class ModuleProgressSelected extends ModuleProgressEvent {
  final String _moduleprogressId;

  ModuleProgressSelected(this._moduleprogressId);

  String get moduleprogressId => _moduleprogressId;

  @override
  List<Object> get props => [_moduleprogressId];
}

class ModuleProgressFound extends ModuleProgressEvent {
  final ModuleProgress _moduleprogress;

  ModuleProgressFound(this._moduleprogress);

  ModuleProgress get moduleprogress => _moduleprogress;

  @override
  List<Object> get props => [_moduleprogress];
}

class AnswerGiven extends ModuleProgressEvent {
  final Question _question;
  final ModuleProgress _progress;
  final Answer? _answer;
  final String _value;

  AnswerGiven(this._question, this._progress, this._answer, this._value);

  Question get question => _question;
  ModuleProgress get progress => _progress;
  String get value => _value;
  Answer? get answer => _answer;

  @override
  List<Object?> get props => [_question, _progress, _answer, _value];
}

class ModuleCompleted extends ModuleProgressEvent {
  final ModuleProgress _moduleProgress;

  ModuleCompleted(this._moduleProgress);

  ModuleProgress get moduleProgress => _moduleProgress;
  String get moduleProgressId => _moduleProgress.getId();

  @override
  List<Object> get props => [_moduleProgress];
}
