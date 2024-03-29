import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_bloc.dart';
import 'package:mfc_app/blocs/authentication/authentication_event.dart';
import 'package:mfc_app/blocs/profile/profile_bloc.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/formatter.dart';
import 'package:mfc_app/widgets/date_input.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();

  late ProfileBloc _profileBloc;
  late AuthenticationBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _firstNameController.addListener(_onFirstNameChange);
    _lastNameController.addListener(_onLastNameChange);
    _birthDateController.addListener(_onBirthdateChange);
    _lengthController.addListener(_onLengthChange);
    _targetWeightController.addListener(_onTargetWeightChange);
    context.read<UserRepository>().getUsername().then(
      (String username) {
        _profileBloc.add(ProfileOpened(cognitoId: username));
      },
    );
  }

  _onFirstNameChange() {
    _profileBloc.add(FirstNameChanged(name: _firstNameController.text));
  }

  _onLastNameChange() {
    _profileBloc.add(LastNameChanged(name: _lastNameController.text));
  }

  _onBirthdateChange() {
    _profileBloc.add(BirthdateChanged(date: _birthDateController.text));
  }

  _onLengthChange() {
    _profileBloc.add(LengthChanged(length: _lengthController.text));
  }

  _onTargetWeightChange() {
    _profileBloc.add(TargetWeightChanged(weight: _targetWeightController.text));
  }

  _onSubmit() {
    _profileBloc.add(
      ProfileSubmitted(
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          birthDate: _birthDateController.text,
          length: _lengthController.text,
          targetWeight: _targetWeightController.text),
    );
  }

  _onSelectMenu(String value) async {
    switch (value) {
      case 'Logout':
        _authBloc.add(
          AuthenticationLoggedOut(),
        );
        break;
      case 'Account verwijderen':
        if (!await launchUrl(
            Uri.parse("https://myfoodcoach.nl/account-verwijderen"))) {
          throw 'Could not launch account remove page';
        }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _birthDateController.dispose();
    _lengthController.dispose();
    _targetWeightController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mijn Profiel".toUpperCase()),
        actions: [
          PopupMenuButton(
            onSelected: _onSelectMenu,
            itemBuilder: (BuildContext context) {
              return {'Account verwijderen', 'Logout'}
                  .map((String choice) => PopupMenuItem(
                        child: Text(choice),
                        value: choice,
                      ))
                  .toList();
            },
          ),
        ],
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is EditProfileState &&
              state.profile != null &&
              !state.loaded) {
            _firstNameController.text = state.profile?.firstName ?? "";
            _lastNameController.text = state.profile?.lastName ?? "";
            _birthDateController.text =
                Formatter.formatTemporalDate(state.profile!.birthDate) ?? "";
            _lengthController.text =
                Formatter.formatDecimal(state.profile?.length, decimals: 2) ??
                    "";
            _targetWeightController.text =
                Formatter.formatDecimal(state.profile?.targetWeight) ?? "";
            _profileBloc.add(ProfileLoadingDone());
          }
          if (state is ProfileSuccessState) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Text(
                        "Profiel opgeslagen",
                      ),
                    ],
                  ),
                ),
              );
          }
          if (state is ProfileFailureState) {
            ScaffoldMessenger.of(context)
              ..removeCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Container(
                    height: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Profiel niet opgeslagen",
                        ),
                        Text(state.error)
                      ],
                    ),
                  ),
                ),
              );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => !state.isFirstNameValid
                          ? 'Voornaam is niet geldig'
                          : null,
                      keyboardType: TextInputType.name,
                      controller: _firstNameController,
                      decoration: InputDecoration(labelText: "Voornaam"),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => !state.isLastNameValid
                          ? 'Achternaam niet geldig'
                          : null,
                      keyboardType: TextInputType.name,
                      controller: _lastNameController,
                      decoration: InputDecoration(labelText: "Achternaam"),
                    ),
                    DateInput(
                      labelText: "Geboortedatum",
                      validator: (_) => !state.isLengthValid
                          ? 'Ingevulde lengte ongeldig'
                          : null,
                      controller: _birthDateController,
                      onDateSelected: (p0) => null,
                      firstDate: DateTime.parse("1940-01-01"),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => !state.isLengthValid
                          ? 'Ingevulde lengte ongeldig'
                          : null,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      controller: _lengthController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: "Lengte",
                        suffix: Text("m"),
                      ),
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (_) => !state.isWeightValid
                          ? 'Ingevulde gewicht ongeldig'
                          : null,
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      controller: _targetWeightController,
                      autocorrect: false,
                      decoration: InputDecoration(
                        labelText: "Streefgewicht",
                        suffix: Text("kg"),
                      ),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                      ),
                      onPressed: state.isValid() ? _onSubmit : null,
                      child: Text("Opslaan"),
                    ),
                    if (!state.isValid())
                      Text("Niet alle velden zijn goed ingevuld"),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
