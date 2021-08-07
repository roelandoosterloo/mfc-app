import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/models/quiz.dart';

class CourseRepository {
  final FirebaseFirestore _firestore;
  late CollectionReference _collection;

  CourseRepository({FirebaseFirestore? firestore, required User user})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _collection = _firestore.collection('courses').withConverter(
      fromFirestore: (snapshot, _) {
        var data = snapshot.data();
        return data != null ? Course.fromJson(snapshot.id, data) : null;
      },
      toFirestore: (course, _) {
        if (course != null) {
          Course c = (course as Course);
          return c.toJson();
        }
        return Map();
      },
    );
  }

  Stream<List<Course>> refreshCourseList() {
    return _collection
        .orderBy(
          'name',
          descending: false,
        )
        .limit(200)
        .snapshots()
        .map((QuerySnapshot snapshot) =>
            snapshot.docs.map((e) => e.data() as Course).toList());
  }

  Future<Course?> getCourse(String courseId) async {
    DocumentSnapshot<Object?> doc = await _collection.doc(courseId).get();
    if (doc.exists) {
      Course course = doc.data() as Course;
      course.modules = await getCourseModules(courseId);
      return course;
    }
  }

  Future<List<Module>> getCourseModules(String courseId) async {
    QuerySnapshot<Map<String, dynamic>> result = await _collection
        .doc(courseId)
        .collection('modules')
        .orderBy('index')
        .limit(200)
        .get();
    return result.docs.map((e) => Module.fromJson(e.id, e.data())).toList();
  }

  Future<Module?> getModule(String courseId, String moduleId) async {
    DocumentSnapshot<Map<String, dynamic>> doc = await _collection
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .get();
    if (doc.exists) {
      Module module = Module.fromJson(doc.id, doc.data()!);
      module.assignments = await getModuleAssignments(courseId, moduleId);
      return module;
    }
  }

  Future<List<Question>> getModuleAssignments(
      String courseId, String moduleId) async {
    QuerySnapshot<Map<String, dynamic>> result = await _collection
        .doc(courseId)
        .collection('modules')
        .doc(moduleId)
        .collection('assignments')
        .limit(200)
        .get();
    return result.docs.map((e) => Question.fromJson(e.id, e.data())).toList();
  }
}
