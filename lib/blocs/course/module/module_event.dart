part of 'module_bloc.dart';

abstract class ModuleProgressEvent extends Equatable {
  const ModuleProgressEvent();

  @override
  List<Object> get props => [];
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
  final String _answer;

  AnswerGiven(this._question, this._progress, this._answer);

  Question get question => _question;
  ModuleProgress get progress => _progress;
  String get answer => _answer;

  @override
  List<Object> get props => [_question, _progress, _answer];
}
