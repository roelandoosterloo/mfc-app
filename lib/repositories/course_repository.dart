import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/models/course/Module.dart';

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

  Future<Module?> getModule(String courseId, String moduleId) async {
    String graphQLDocument = '''
    query MyQuery {
      getModule(id: "$moduleId") {
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
            options {
              items {
                id
                label
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
    Module module = Module.fromJson(json['getModule']);
    return module;
  }
}
