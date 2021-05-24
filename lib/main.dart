import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/authentication/authentication_state.dart';
import 'package:mfc_app/blocs/measurement/measurement_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/navigation/router_delegate.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/color_generator.dart';
import 'package:mfc_app/utils/simple_bloc_observer.dart';
import 'package:mfc_app/widgets/loading.dart';

import 'blocs/authentication/authentication_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MFC App',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xff2b8474)),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            AppRouterDelegate routerDelegate = AppRouterDelegate();
            FirebaseAuth auth = FirebaseAuth.instance;
            UserRepository userRepo = UserRepository(firebaseAuth: auth);
            // MeasurementRepository measurementRepo =
            //     MeasurementRepository(firestore: FirebaseFirestore.instance);
            NavigationBloc navigationBloc = NavigationBloc();
            BlocProvider<NavigationBloc> navProvider =
                BlocProvider<NavigationBloc>(
              create: (context) => navigationBloc,
            );

            AuthenticationBloc authBloc = AuthenticationBloc(
              userRepo: userRepo,
              navigationBloc: navigationBloc,
            );
            authBloc.add(
              AuthenticationStarted(),
            );
            BlocProvider<AuthenticationBloc> authProvider =
                BlocProvider<AuthenticationBloc>(
              create: (context) {
                return authBloc;
              },
            );
            Router router = Router(
              routerDelegate: routerDelegate,
              backButtonDispatcher: RootBackButtonDispatcher(),
            );

            return MultiBlocProvider(
              providers: [authProvider, navProvider],
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  List<RepositoryProvider> providers = [
                    RepositoryProvider<UserRepository>(
                        create: (context) => userRepo),
                  ];
                  if (state is AuthenticationSuccess) {
                    providers.add(
                      RepositoryProvider<MeasurementRepository>(
                        create: (context) =>
                            MeasurementRepository(user: state.firebaseUser),
                      ),
                    );
                  }
                  return MultiRepositoryProvider(
                    providers: providers,
                    child: router,
                  );
                },
              ),
            );
          }
          return Loading();
        },
      ),
    );
  }
}
