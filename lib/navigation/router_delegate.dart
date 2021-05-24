import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/screens/home/home_page.dart';
import 'package:mfc_app/screens/login/login_page.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_page.dart';
import 'package:mfc_app/screens/measurment/measurement_page.dart';
import 'package:mfc_app/screens/register/register_page.dart';

class AppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState>? _navKey;

  AppRouterDelegate({
    GlobalKey<NavigatorState>? navKey,
  })  : _navKey = navKey,
        super();

  List<Page> buildStack(NavigationState state) {
    if (state is AuthenticationNavigation) {
      return [
        LoginPage(),
        if (state.isRegister) RegisterPage(),
      ];
    }
    if (state is AppNavigation) {
      return [
        HomePage(),
        if (state.isMeasurments) MeasurementPage(),
        if (state.isAddMeasurement) AddMeasurementPage(),
      ];
    }
    return [LoginPage()];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Navigator(
          key: _navKey,
          pages: buildStack(state),
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
