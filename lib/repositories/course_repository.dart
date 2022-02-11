import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';

class CourseRepository {
  Future<List<Course>> listSubscribedCourses() async {
    String graphQLDocument = '''
    query ListSubscribedCourses {
      listMemberships {
        items {
          program {
            courses {
              items {
                course {
                  id
                  name
                  description
                  coverImage
                }
              }
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
    List<dynamic> memberships = json["listMemberships"]["items"];
    List<dynamic> courses = memberships
        .map((item) => item["program"]["courses"]["items"])
        .expand((element) => element)
        .map((item) => item["course"])
        .toList();
    List<Course> enrolledCourses =
        courses.map((it) => Course.fromJson(it)).toList();
    return enrolledCourses;
  }

  Future<List<Course>> listCourses() async {
    String graphQLDocument = ''' 
    query ListCourses {
      listCourses {
        items {
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
    List<dynamic> items = json["listCourses"]["items"];
    List<Course> enrolledCourses =
        items.map((it) => Course.fromJson(it)).toList();
    return enrolledCourses;
  }

  Future<List<Enrollment>> listEnrolledCourses() async {
    String graphQLDocument = ''' 
    query ListEnrolledCourses {
      listEnrollments {
        items {
          id
          enrolledAt
          startedAt
          completedAt
          moduleSchedule {
            items {
              id
              availableAt
              completedAt
            }
          }
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

  Future<bool> setCourseStartedAt(String id) async {
    String graphQLDocument = '''
    mutation setStartedAt {
      updateEnrollment(input: {
        id: "$id",
        startedAt: "${DateTime.now().toUtc().toIso8601String()}",
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
    GraphQLResponse result = await op.response;
    return true;
  }

  Future<bool> setModuleStartedAt(String id) async {
    String graphQLDocument = '''
    mutation setModuleStartedAt {
      updateModuleProgress(input: {
        id: "$id",
        startedAt: "${DateTime.now().toUtc().toIso8601String()}",
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
    GraphQLResponse result = await op.response;
    return true;
  }

  Future<Enrollment?> getEnrollment(String id) async {
    String graphQLDocument = '''
    query MyQuery {
      getEnrollment(id: "$id") {
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
        moduleSchedule {
          items {
            id
            availableAt
            startedAt
            completedAt
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

  Future<bool> completeModule(String moduleProgressId) async {
    String graphQLDocument = '''
    mutation completeModule {
      updateModuleProgress(input: {
        id: "$moduleProgressId",
        completedAt: "${DateTime.now().toUtc().toIso8601String()}"
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

  Future<bool> createAnswer(
    String questionId,
    String moduleProgressId,
    String value,
  ) async {
    String graphQLDocument = '''
    mutation submitAnswer {
      createAnswer(input: {
        questionId: "$questionId",
        moduleProgressId: "$moduleProgressId",
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
    await op.response;
    return true;
  }

  Future<Enrollment> createEnrollment(String userId, String courseId) async {
    String graphQLDocument = '''
    mutation createEnrollment {
      createEnrollment(input: {
        cognitoId: "$userId"
        courseId: "$courseId"
        enrolledAt: "${DateTime.now().toUtc().toIso8601String()}"
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
