import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState>? _navKey;

  AppRouterDelegate({
    GlobalKey<NavigatorState>? navKey,
  })  : _navKey = navKey,
        super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Navigator(
          key: _navKey,
          pages: state.stack.toList(),
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;

            BlocProvider.of<NavigationBloc>(context).add(NavigatedBack());
            return true;
          },
        );
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navKey;

  @override
  Future<void> setNewRoutePath(configuration) async {}
}
