import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/screens/course/single/course_single_page.dart';
import 'package:mfc_app/screens/course/list/course_list_page.dart';
import 'package:mfc_app/screens/home/home_page.dart';
import 'package:mfc_app/screens/login/login_page.dart';
import 'package:mfc_app/screens/measurment/add_measurement/add_measurement_page.dart';
import 'package:mfc_app/screens/measurment/measurement_page.dart';
import 'package:mfc_app/screens/module/single/module_single_page.dart';
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
      List<Page> stack = [
        HomePage(),
      ];
      if (state.isMeasurments) stack.add(MeasurementPage());
      if (state.isAddMeasurement) stack.add(AddMeasurementPage());

      if (state is CourseNavigation) {
        stack.add(CourseListPage());
        if (state.courseId != null)
          stack.add(
            CourseSinglePage(
              courseId: state.courseId!,
            ),
          );
        if (state.moduleId != null)
          stack.add(
            ModuleSinglePage(
              state.courseId!,
              state.moduleId!,
            ),
          );
      }

      return stack;
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
