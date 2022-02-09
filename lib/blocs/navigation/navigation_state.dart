part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final IStack<Page> stack;

  const NavigationState({required this.stack});

  NavigationState goBack();

  NavigationState goTo(Page p);

  @override
  List<Object> get props => [stack];
}

class NavigationInitial extends NavigationState {
  NavigationInitial() : super(stack: IStack([LandingPage()]));

  @override
  NavigationState goBack() {
    return NavigationInitial();
  }

  @override
  NavigationState goTo(Page p) {
    return NavigationInitial();
  }
}

class AuthenticationNavigation extends NavigationState {
  AuthenticationNavigation({required IStack<Page> stack}) : super(stack: stack);

  factory AuthenticationNavigation.initial() {
    return AuthenticationNavigation(
      stack: IStack([
        LandingPage(),
      ]),
    );
  }

  @override
  NavigationState goBack() {
    if (stack.length == 1) {
      return AuthenticationNavigation.initial();
    }
    return AuthenticationNavigation(stack: stack.pop());
  }

  @override
  NavigationState goTo(Page p) {
    return AuthenticationNavigation(stack: stack.push(p));
  }
}

class AppNavigation extends NavigationState {
  AppNavigation({required IStack<Page> stack}) : super(stack: stack);

  factory AppNavigation.initial() {
    return AppNavigation(
      stack: IStack([HomePage()]),
    );
  }

  @override
  NavigationState goBack() {
    if (stack.length == 1) {
      return this;
    }
    return AppNavigation(stack: stack.pop());
  }

  @override
  List<Object> get props => [stack];

  @override
  NavigationState goTo(Page p) {
    return AppNavigation(stack: stack.push(p));
  }
}

// class CourseNavigation extends AppNavigation {
//   CourseNavigation({required stack}) : super(stack: stack);

//   @override
//   NavigationState goBack() {
//     if (stack.length == 1) {
//       return AppNavigation.initial();
//     }
//     return CourseNavigation(stack: stack.pop());
//   }

//   @override
//   List<Object> get props => [stack];
// }
