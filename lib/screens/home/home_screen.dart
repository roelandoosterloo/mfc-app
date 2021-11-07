import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);
    AuthenticationBloc _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Home is where the heart is",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  NavigationEvent event = NavigatedToMeasurements();
                  _navBloc.add(event);
                },
                child: Text("Measurements"),
              ),
              ElevatedButton(
                onPressed: () {
                  NavigationEvent event = NavigatedToCourseList();
                  _navBloc.add(event);
                },
                child: Text("Course"),
              ),
              ElevatedButton(
                onPressed: () {
                  AuthenticationEvent event = AuthenticationLoggedOut();
                  _authBloc.add(event);
                },
                child: Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
