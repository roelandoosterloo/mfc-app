part of 'list_program_bloc.dart';

abstract class ListProgramState extends Equatable {
  const ListProgramState();

  @override
  List<Object> get props => [];
}

class ListProgramInitial extends ListProgramState {}

class Loaded extends ListProgramState {
  final List<Program> _programs;
  final List<Membership> _memberships;

  Loaded(List<Program> _programs, List<Membership> memberships)
      : _programs = _programs,
        _memberships = memberships;

  List<Program> get programs => _programs;
  List<Membership> get memberships => _memberships;

  @override
  List<Object> get props => [_programs, _memberships];
}

class Loading extends ListProgramState {}

class NoProgramAvailable extends ListProgramState {}

class FailedLoading extends ListProgramState {
  final String _error;

  FailedLoading(this._error);

  get error => _error;

  @override
  List<Object> get props => [_error];
}

class PaymentPending extends Loaded {
  final String _programId;

  PaymentPending({
    required String programId,
    required List<Program> programs,
    required List<Membership> memberships,
  })  : _programId = programId,
        super(programs, memberships);

  @override
  List<Object> get props => [
        ...super.props,
        _programId,
      ];

  get programId => _programId;
}

class PaymentFailed extends Loaded {
  final String _message;

  PaymentFailed({
    required String message,
    required List<Program> programs,
    required List<Membership> memberships,
  })  : _message = message,
        super(programs, memberships);

  get message => _message;

  @override
  List<Object> get props => [
        ...super.props,
        _message,
      ];
}
