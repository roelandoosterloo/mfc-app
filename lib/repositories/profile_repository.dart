import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/utils/api_helper.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ProfileRepository {
  Future<Profile> createProfile(String cognitoId) async {
    Profile profile = Profile(cognitoId: cognitoId);
    final request = ModelMutations.create(profile);
    Profile? result = await ModelHelpers.create(request);

    if (result == null) {
      throw Exception("Unexpected failure");
    }

    return result;
  }

  Future<Profile> getProfile(String cognitoId) async {
    final request = ModelQueries.list(Profile.classType);
    List<Profile> profiles =
        (await ModelHelpers.listAll(request)).whereType<Profile>().toList();

    if (profiles.isEmpty) {
      return createProfile(cognitoId);
    }

    return profiles.first;
  }

  Future<bool> submitProfile(Profile p) async {
    final request = ModelMutations.update(p);
    final result = await ModelHelpers.update(request);

    return result;
  }

  Future<bool> setCurrentCourse(Profile profile, String courseId) async {
    Profile changed = profile.copyWith(currentCourseId: courseId);
    final request = ModelMutations.update(changed);
    final result = await ModelHelpers.update(request);
    return result;
  }
}
