part of 'list_program_bloc.dart';

abstract class ListProgramEvent extends Equatable {
  const ListProgramEvent();

  @override
  List<Object> get props => [];
}

class ListProgramOpened extends ListProgramEvent {}

class PurchaseProgram extends ListProgramEvent {
  final Program _program;

  PurchaseProgram(this._program);

  Program get program => _program;

  @override
  List<Object> get props => [_program];
}

class PurchaseFailed extends ListProgramEvent {
  final String _error;

  PurchaseFailed(this._error);

  @override
  List<Object> get props => [_error];
}

class PurchaseCompleted extends ListProgramEvent {}

class PurchasesRestoreRequested extends ListProgramEvent {}
