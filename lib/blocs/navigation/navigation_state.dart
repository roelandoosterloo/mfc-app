part of 'navigation_bloc.dart';

abstract class NavigationState extends Equatable {
  final IStack<Page> stack;
  final bool wentBack;

  const NavigationState({required this.stack, this.wentBack = false});

  NavigationState goBack();

  NavigationState goTo(Page p);

  @override
  List<Object> get props => [stack];
}

class NavigationInitial extends NavigationState {
  NavigationInitial(bool wentBack)
      : super(stack: IStack([InitPage()]), wentBack: wentBack);

  @override
  NavigationState goBack() {
    return NavigationInitial(true);
  }

  @override
  NavigationState goTo(Page p) {
    return NavigationInitial(false);
  }

  @override
  List<Object> get props => [stack, wentBack];
}

class AuthenticationNavigation extends NavigationState {
  AuthenticationNavigation({required IStack<Page> stack, bool wentBack = false})
      : super(stack: stack, wentBack: wentBack);

  factory AuthenticationNavigation.initial({bool? wentBack}) {
    return AuthenticationNavigation(
      stack: IStack([
        LandingPage(),
      ]),
      wentBack: wentBack ?? false,
    );
  }

  @override
  NavigationState goBack() {
    if (stack.length == 1) {
      return AuthenticationNavigation.initial(wentBack: true);
    }
    return AuthenticationNavigation(stack: stack.pop(), wentBack: true);
  }

  @override
  NavigationState goTo(Page p) {
    if (p.name == stack.peek()?.name) {
      return AuthenticationNavigation(stack: stack);
    }
    return AuthenticationNavigation(stack: stack.push(p));
  }

  @override
  List<Object> get props => [stack, wentBack];
}

class AppNavigation extends NavigationState {
  AppNavigation({required IStack<Page> stack, bool wentBack = false})
      : super(stack: stack, wentBack: wentBack);

  factory AppNavigation.initial({bool? wentBack}) {
    return AppNavigation(
      stack: IStack([HomePage()]),
      wentBack: wentBack ?? false,
    );
  }

  @override
  NavigationState goBack() {
    if (stack.length == 1) {
      return this;
    }
    return AppNavigation(stack: stack.pop(), wentBack: true);
  }

  @override
  List<Object> get props => [stack, wentBack];

  @override
  NavigationState goTo(Page p) {
    return AppNavigation(stack: stack.push(p));
  }
}
