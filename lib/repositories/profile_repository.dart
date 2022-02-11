import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Profile.dart';

class ProfileRepository {
  Future<Profile> getProfile(String id) async {
    String graphQLDocument = '''
    query MyQuery {
      listProfiles(filter: {cognitoId: {eq: "$id"}}) {
        items {
            id
            firstName
            lastName
            birthDate
            length
            targetWeight
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
      print(ex);
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
      print(result.errors);
    } catch (ex) {
      print(ex);
    }
    return true;
  }
}
