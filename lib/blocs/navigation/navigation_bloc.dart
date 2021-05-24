import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationInitial());

  @override
  Stream<NavigationState> mapEventToState(NavigationEvent event) async* {
    print(event);
    if (event is NavigatedBack) {
      yield* _mapBackToState();
    } else if (event is NavigatedToRegister) {
      yield* _mapRegisterClickedToState();
    } else if (event is NavigatedToLogin) {
      yield* _mapLoginToState();
    } else if (event is NavigatedToHome) {
      yield* _mapHomeToState();
    } else if (event is NavigatedToMeasurements) {
      print("right");
      yield* _mapMeasurementsToState();
    } else if (event is NavigatedToAddMeasurement) {
      yield* _mapAddMeasurementToState();
    }
  }

  Stream<NavigationState> _mapBackToState() async* {
    yield state.goBack();
  }

  Stream<NavigationState> _mapRegisterClickedToState() async* {
    yield AuthenticationNavigation.register();
  }

  Stream<NavigationState> _mapLoginToState() async* {
    yield AuthenticationNavigation.login();
  }

  Stream<NavigationState> _mapHomeToState() async* {
    yield AppNavigation.home();
  }

  Stream<NavigationState> _mapMeasurementsToState() async* {
    print("yielding state");
    yield AppNavigation(isMeasurments: true);
  }

  Stream<NavigationState> _mapAddMeasurementToState() async* {
    yield AppNavigation.addMeasurement();
  }
}
