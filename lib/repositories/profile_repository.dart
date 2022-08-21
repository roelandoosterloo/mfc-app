import 'dart:convert';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProfileRepository {
  Future<Profile> createProfile(String cognitoId) async {
    String graphQLDocument = '''
    mutation createProfile {
      createProfile(input: {
        cognitoId: "$cognitoId"
      }) {
        id
        firstName
        lastName
        birthDate
        length
        targetWeight
        currentCourseId
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    try {
      GraphQLResponse response = await op.response;
      Map<String, dynamic> json = jsonDecode(response.data);
      return Profile.fromJson(json['createProfile']);
    } catch (ex) {
      await Sentry.captureException(ex);
      print(ex);
      throw ex;
    }
  }

  Future<Profile> getProfile(String cognitoId) async {
    String graphQLDocument = '''
    query MyQuery {
      listProfiles(filter: {cognitoId: {eq: "$cognitoId"}}) {
        items {
          id
          firstName
          lastName
          birthDate
          length
          targetWeight
          currentCourseId
        }
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    GraphQLResponse response = await op.response;
    Map<String, dynamic> json = jsonDecode(response.data);
    List<dynamic> items = json['listProfiles']['items'];
    if (items.isEmpty) {
      return createProfile(cognitoId);
    }
    List<Profile> profiles = items.map((it) => Profile.fromJson(it)).toList();
    return profiles.first;
  }

  Future<bool> submitProfile(Profile p) async {
    String graphQLDocument = '''
    mutation updateProfile {
      updateProfile(input: {
        id: "${p.id}",
        firstName: "${p.firstName}",
        lastName: "${p.lastName}",
        birthDate: ${p.formattedBirthdate != null ? '"${p.formattedBirthdate}"' : null},
        length: ${p.length},
        targetWeight: ${p.targetWeight}
      }) {
        id
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    try {
      GraphQLResponse result = await op.response;
      print(result.errors);
    } catch (ex) {
      await Sentry.captureException(ex);
    }
    return true;
  }

  Future<bool> setCurrentCourse(String profileId, String courseId) async {
    String graphQLDocument = '''
    mutation setCurrentCourse {
      updateProfile(input: {
        id: "$profileId",
        currentCourseId: "$courseId",
      }) {
        id
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    try {
      GraphQLResponse result = await op.response;
    } catch (ex) {
      await Sentry.captureException(ex);
    }
    return true;
  }
}
