import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/authentication/authentication_state.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepo;
  final NavigationBloc _navigationBloc;

  AuthenticationBloc({
    required UserRepository userRepo,
    required NavigationBloc navigationBloc,
  })  : _userRepo = userRepo,
        _navigationBloc = navigationBloc,
        super(AuthenticationInitial()) {
    on<AuthenticationStarted>(_onAuthStarted);
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
    _listenForEvents();
  }

  StreamSubscription _listenForEvents() {
    StreamSubscription hubSubscription =
        Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case 'SIGNED_IN':
          print('USER IS SIGNED IN');
          break;
        case 'SIGNED_OUT':
          this.add(AuthenticationLoggedOut());
          print('USER IS SIGNED OUT');
          break;
        case 'SESSION_EXPIRED':
          this.add(AuthenticationLoggedOut());
          break;
        case 'USER_DELETED':
          this.add(AuthenticationLoggedOut());
          break;
      }
    });
    return hubSubscription;
  }

  void _onLoggedIn(
    AuthenticationLoggedIn event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      AuthUser user = await _userRepo.getUser();
      emit(AuthenticationSuccess(user));
      _navigationBloc.add(NavigatedToHome());
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      emit(AuthenticationFailure());
      _navigationBloc.add(NavigatedToLogin());
    }
  }

  void _onLoggedOut(
    AuthenticationLoggedOut event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _userRepo.signOut();
    _navigationBloc.add(NavigatedToLogin());
  }

  void _onAuthStarted(
    AuthenticationStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    final isSignedIn = await _userRepo.isSignedIn();
    if (isSignedIn) {
      AuthUser user = await _userRepo.getUser();
      emit(AuthenticationSuccess(user));
      _navigationBloc.add(NavigatedToHome());
    } else {
      emit(AuthenticationFailure());
      _navigationBloc.add(NavigatedToLogin());
    }
  }
}
