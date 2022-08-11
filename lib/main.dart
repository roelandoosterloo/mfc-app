import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/amplifyconfiguration.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/enrollment/enrollment_bloc.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/navigation/router_delegate.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/repositories/measurement_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/program_repository.dart';
import 'package:mfc_app/repositories/store_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/screens/init/init_screen.dart';
import 'package:mfc_app/utils/color_generator.dart';
import 'package:mfc_app/utils/simple_bloc_observer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'blocs/authentication/authentication_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sentry.init(
    (options) {
      options.dsn = kDebugMode
          ? ''
          : 'https://b7a72c6868214d00a814d9e305388e06@o1334244.ingest.sentry.io/6600508';
      options.tracesSampleRate = 1.0;
    },
    appRunner: () {
      if (kDebugMode) {
        Bloc.observer = SimpleBlocObserver();
      }
      return runApp(
        MyAmplifyApp(),
      );
    },
  );
}

class MyAmplifyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('nl'),
        Locale('en'),
      ],
      title: 'MyFoodCoach',
      theme: ThemeData(
        primarySwatch: createMaterialColor(
          Color(0xff2b8474),
        ),
        secondaryHeaderColor: Color(0xfff44336),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(
                fontFamily: 'Stratum',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(fontFamily: 'Stratum'),
          unselectedLabelStyle: TextStyle(fontFamily: 'Stratum'),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(fontFamily: 'Stratum', fontSize: 24),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
          ),
        ),
        fontFamily: 'Roboto',
      ),
      home: MainPage(),
    );
  }
}

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
    await Future.delayed(
      Duration(seconds: 1),
    );
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
    } catch (e, stack) {
      await Sentry.captureException(e, stackTrace: stack);
      print('An error occurred while configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return InitScreen();
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
            RepositoryProvider<ProgramRepository>(
              create: (context) => ProgramRepository(),
            ),
            RepositoryProvider<StoreRepository>(
              create: (context) => StoreRepository(),
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
