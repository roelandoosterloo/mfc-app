import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/ModelProvider.dart';
import 'package:mfc_app/repositories/queries.dart';
import 'package:mfc_app/utils/api_helper.dart';

class CourseRepository {
  Future<List<Course>> listSubscribedCourses() async {
    // final request = ModelQueries.list(Membership.classType);
    final request = Queries.listSubscribedCourses();
    List<Membership?> memberships = await ModelHelpers.listAll(request);

    return memberships
        .expand(
          (e) => e?.program?.courses ?? <ProgramCourse>[],
        )
        .map((e) => e.course)
        .toList();
  }

  Future<List<Course?>> listCourses() async {
    final request = ModelQueries.list(Course.classType, limit: 1000);
    List<Course?> courses = await ModelHelpers.listAll(request);
    return courses;
  }

  Future<List<Enrollment?>> listEnrolledCourses() async {
    // final request = ModelQueries.list(Enrollment.classType, limit: 1000);
    final request = Queries.listEnrolledCourses();
    List<Enrollment?> enrollments = await ModelHelpers.listAll(request);
    return enrollments;
  }

  Future<bool> setCourseStartedAt(Enrollment e) async {
    final change = e.copyWith(startedAt: TemporalDateTime.now());
    final request = ModelMutations.update(change);

    final result = await ModelHelpers.update(request);
    return result;
  }

  Future<bool> setModuleStartedAt(ModuleProgress progress) async {
    final change = progress.copyWith(startedAt: TemporalDateTime.now());
    final request = ModelMutations.update(change);

    final result = await ModelHelpers.update(request);
    return result;
  }

  Future<Enrollment?> getEnrollment(String id) async {
    // final request = ModelQueries.get(Enrollment.classType, id);
    final request = Queries.getEnrollment(id);
    Enrollment? result = await ModelHelpers.get(request);
    return result;
  }

  Future<ModuleProgress?> getModuleProgress(String progressId) async {
    // final request = ModelQueries.get(ModuleProgress.classType, progressId);
    final request = Queries.getModuleProgress(progressId);
    ModuleProgress? result = await ModelHelpers.get(request);
    return result;
  }

  Future<bool> completeModule(ModuleProgress progress) async {
    final change = progress.copyWith(completedAt: TemporalDateTime.now());
    final request = ModelMutations.update(change);

    final result = await ModelHelpers.update(request);
    return result;
  }

  Future<bool> completeCourse(Enrollment enrollment) async {
    final change = enrollment.copyWith(completedAt: TemporalDateTime.now());
    final request = ModelMutations.update(change);

    final result = await ModelHelpers.update(request);
    return result;
  }

  Future<Answer?> createAnswer(
    Question question,
    String moduleProgressId,
    String value,
  ) async {
    Answer answer = Answer(
        moduleProgressId: moduleProgressId, question: question, answer: value);
    final request = ModelMutations.create(answer);
    Answer? result = await ModelHelpers.create(request);
    return result;
  }

  Future<bool> updateAnswer(Answer answer, String value) async {
    final change = answer.copyWith(answer: value);
    final request = ModelMutations.update(change);

    final result = await ModelHelpers.update(request);
    return result;
  }

  Future<bool> generateCourseSchedule(
      String courseId, String enrollmentId) async {
    String graphQLDocument = '''
    mutation generateSchedule {
      generateCourseSchedule(
        startDate: "${DateTime.now().toUtc().toIso8601String()}"
        courseId: "$courseId"
        enrollmentId: "$enrollmentId"
      )
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    GraphQLResponse res = await op.response;
    return true;
  }

  Future<Enrollment> createEnrollment(String userId, String courseId) async {
    String graphQLDocument = '''
    mutation createEnrollment {
      createEnrollment(input: {
        owner: "$userId"
        courseId: "$courseId"
        enrolledAt: "${DateTime.now().toUtc().toIso8601String()}"
        startedAt: "${DateTime.now().toUtc().toIso8601String()}"
      }) {
        id
        enrolledAt
        startedAt
        completedAt
        course {
          id
          name
          description
          coverImage
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
    Enrollment enrolledCourse = Enrollment.fromJson(json['createEnrollment']);
    await generateCourseSchedule(courseId, enrolledCourse.id);
    return enrolledCourse;
  }
}
