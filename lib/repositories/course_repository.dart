import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';

class CourseRepository {
  Future<List<Enrollment>> listEnrolledCourses() async {
    String graphQLDocument = ''' 
    query ListEnrolledCourses {
      listEnrollments {
        items {
          id
          startDate
          course {
            id
            name
            description
            coverImage
          }
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
    List<dynamic> items = json["listEnrollments"]["items"];
    List<Enrollment> enrolledCourses =
        items.map((it) => Enrollment.fromJson(it)).toList();
    return enrolledCourses;
  }

  Future<Enrollment?> getEnrollment(String id) async {
    String graphQLDocument = '''
    query MyQuery {
      getEnrollment(id: "$id") {
        id
        startDate
        course {
          id
          name
          description
          coverImage
        }
        moduleSchedule {
          items {
            id
            availableAt
            module {
              index
              name
              id
              coverImage
            }
          }
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
    Enrollment enrolledCourse = Enrollment.fromJson(json['getEnrollment']);
    return enrolledCourse;
  }

  Future<ModuleProgress?> getModuleProgress(String progressId) async {
    String graphQLDocument = '''
    query MyQuery {
      getModuleProgress(id: "$progressId") {
        id
        availableAt
        module {
          coverImage
          description
          id
          name
          videoUrl
          index
          assignments {
            items {
              id
              type
              introduction
              question
              answer {
                id
                answer
              }
              options {
                items {
                  id
                  label
                }
              }
            }
          }
        }
        workbook {
          items {
            id
            questionId
            answer
          }
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
    ModuleProgress module = ModuleProgress.fromJson(json['getModuleProgress']);
    return module;
  }

  Future<bool> createAnswer(
    String questionId,
    String moduleProgressId,
    String value,
  ) async {
    String graphQLDocument = '''
    mutation submitAnswer {
      createAnswer(input: {
        questionId: "$questionId",
        answer: "$value"
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
    var result = await op.response;
    return true;
  }

  Future<bool> updateAnswer(String answerId, String value) async {
    String graphQLDocument = '''
    mutation submitAnswer {
      updateAnswer(input: {
        id: "$answerId",
        answer: "$value"
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
    await op.response;
    return true;
  }
}
