import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NavigationBloc _navBloc = BlocProvider.of<NavigationBloc>(context);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
