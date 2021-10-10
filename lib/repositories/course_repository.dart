import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:mfc_app/models/course/Module.dart';
import 'package:mfc_app/models/course/Course.dart';

class CourseRepository {
  Future<List<Course>> listAvailableCourses() async {
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
    List<Course> courses = items.map((it) => Course.fromJson(it)).toList();
    return courses;
  }

  Future<Course?> getCourse(String courseId) async {
    String graphQLDocument = '''
    query MyQuery {
      getCourse(id: "$courseId") {
        id,
        name,
        description,
        coverImage,
        modules{
          items {
            index,
            name,
            id,
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
    Course course = Course.fromJson(json['getCourse']);
    return course;
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
