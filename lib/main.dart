import 'dart:ui';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/amplifyconfiguration.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/enrollment/enrollment_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/navigation/router_delegate.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/color_generator.dart';
import 'package:mfc_app/utils/simple_bloc_observer.dart';

import 'blocs/authentication/authentication_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(
      MyAmplifyApp(),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyAmplifyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Amplify MFC App',
      theme: ThemeData(
        primarySwatch: createMaterialColor(
          Color(0xff2b8474),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontFamily: 'Stratum'),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'Stratum', fontSize: 24),
        ),
        fontFamily: 'Roboto',
      ),
      home: MainPage(),
    );
  }
}

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'MFC App',
//       theme: ThemeData(
//         primarySwatch: createMaterialColor(Color(0xff2b8474)),
//       ),
//       home: FutureBuilder(
//         future: _initialization,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             AppRouterDelegate routerDelegate = AppRouterDelegate();
//             FirebaseAuth auth = FirebaseAuth.instance;
//             UserRepository userRepo = UserRepository(firebaseAuth: auth);
//             NavigationBloc navigationBloc = NavigationBloc();
//             BlocProvider<NavigationBloc> navProvider =
//                 BlocProvider<NavigationBloc>(
//               create: (context) => navigationBloc,
//             );

//             AuthenticationBloc authBloc = AuthenticationBloc(
//               userRepo: userRepo,
//               navigationBloc: navigationBloc,
//             );
//             authBloc.add(
//               AuthenticationStarted(),
//             );
//             BlocProvider<AuthenticationBloc> authProvider =
//                 BlocProvider<AuthenticationBloc>(
//               create: (context) {
//                 return authBloc;
//               },
//             );
//             Router router = Router(
//               routerDelegate: routerDelegate,
//               backButtonDispatcher: RootBackButtonDispatcher(),
//             );

//             return MultiBlocProvider(
//               providers: [authProvider, navProvider],
//               child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
//                 builder: (context, state) {
//                   List<RepositoryProvider> repoProviders = [
//                     RepositoryProvider<UserRepository>(
//                         create: (context) => userRepo),
//                   ];
//                   if (state is AuthenticationSuccess) {
//                     repoProviders.add(
//                       RepositoryProvider<MeasurementRepository>(
//                         create: (context) =>
//                             MeasurementRepository(user: state.user),
//                       ),
//                     );
//                     repoProviders.add(
//                       RepositoryProvider<CourseRepository>(
//                         create: (context) => CourseRepository(user: state.user),
//                       ),
//                     );
//                   }
//                   return MultiRepositoryProvider(
//                     providers: repoProviders,
//                     child: router,
//                   );
//                 },
//               ),
//             );
//           }
//           return Loading();
//         },
//       ),
//     );
//   }
// }

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool _isLoading = true;

  final AmplifyAuthCognito _authPlugin = AmplifyAuthCognito();
  final AmplifyAPI _apiPlugin = AmplifyAPI();
  final AmplifyStorageS3 _storagePlugin = AmplifyStorageS3();

  @override
  void initState() {
    _initializeApp();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initializeApp() async {
    await _configureAmplify();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([
        _authPlugin,
        _apiPlugin,
        _storagePlugin,
      ]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      print('An error occurred while configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    } else {
      UserRepository userRepo = UserRepository();
      NavigationBloc navBloc = NavigationBloc();
      BlocProvider<NavigationBloc> navProvider = BlocProvider<NavigationBloc>(
        create: (context) => navBloc,
      );
      AuthenticationBloc authBloc = AuthenticationBloc(
        userRepo: userRepo,
        navigationBloc: navBloc,
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
      return MultiBlocProvider(
        providers: [authProvider, navProvider],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider<UserRepository>(create: (context) => userRepo),
            RepositoryProvider<MeasurementRepository>(
              create: (context) => MeasurementRepository(),
            ),
            RepositoryProvider<CourseRepository>(
              create: (context) => CourseRepository(),
            ),
            RepositoryProvider<ProfileRepository>(
              create: (context) => ProfileRepository(),
            ),
          ],
          child: BlocProvider(
            create: (context) => EnrollmentBloc(
              context.read<CourseRepository>(),
            ),
            child: Router(
              routerDelegate: AppRouterDelegate(),
              backButtonDispatcher: RootBackButtonDispatcher(),
            ),
          ),
        ),
      );
    }
  }
}
