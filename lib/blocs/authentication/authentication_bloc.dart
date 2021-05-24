import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/authentication/authentication_state.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepo;
  final NavigationBloc _navigationBloc;

  AuthenticationBloc({
    required UserRepository userRepo,
    required NavigationBloc navigationBloc,
  })   : _userRepo = userRepo,
        _navigationBloc = navigationBloc,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    final user = await _userRepo.getUser();
    if (user != null) {
      yield AuthenticationSuccess(user);
      _navigationBloc.add(NavigatedToHome());
    } else {
      yield AuthenticationFailure();
      _navigationBloc.add(NavigatedToLogin());
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    _userRepo.signOut();
    _navigationBloc.add(NavigatedToLogin());
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepo.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepo.getUser();
      if (user != null) {
        yield AuthenticationSuccess(user);
        _navigationBloc.add(NavigatedToHome());
      } else {
        yield AuthenticationFailure();
        _navigationBloc.add(NavigatedToLogin());
      }
    } else {
      yield AuthenticationFailure();
    }
  }
}
