import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  _onLogin(BuildContext context) {
    BlocProvider.of<NavigationBloc>(context).add(NavigatedToLogin());
  }

  _onRegister(BuildContext context) {
    BlocProvider.of<NavigationBloc>(context).add(NavigatedToRegister());
  }

  _onMoreInfo() async {
    if (!await launch(
        'https://myfoodcoach.nl/12weekseafvalplan?utm_source=mfc_app&utm_medium=landing_page&utm_campaign=mfc_app')) {
      throw "Could not open URL";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/landing.png",
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: min(MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width) -
                        20,
                    child: Image.asset(
                      "assets/images/logo_hd.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Spacer(flex: 1),
                  ElevatedButton(
                    onPressed: () => _onLogin(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 12.0,
                      ),
                      child: Text("INLOGGEN"),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: _onMoreInfo,
                        child: Text(
                          "Meer info",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () => _onRegister(context),
                        child: Text(
                          "Registreren",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
