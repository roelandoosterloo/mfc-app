import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';

import 'Course.dart';

@immutable
class Enrollment extends Model {
  final String id;
  final DateTime _startDate;
  final Course _course;
  final List<ModuleProgress>? _moduleSchedule;

  @override
  String getId() {
    return id;
  }

  DateTime get startDate {
    return _startDate;
  }

  Course get course {
    return _course;
  }

  List<ModuleProgress>? get moduleSchedule {
    return _moduleSchedule;
  }

  const Enrollment._internal(
      {required this.id, required startDate, required course, moduleSchedule})
      : _startDate = startDate,
        _course = course,
        _moduleSchedule = moduleSchedule;

  factory Enrollment(
      {String? id,
      required DateTime startDate,
      required Course course,
      List<ModuleProgress>? moduleSchedule}) {
    return Enrollment._internal(
      id: id == null ? UUID.getUUID() : id,
      startDate: startDate,
      course: course,
      moduleSchedule: moduleSchedule != null
          ? List<ModuleProgress>.unmodifiable(moduleSchedule)
          : null,
    );
  }

  Enrollment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _startDate = DateTime.parse(json['startDate']),
        _course = Course.fromJson(json['course']),
        _moduleSchedule = json['moduleSchedule']?['items'] is List
            ? (json['moduleSchedule']['items'] as List)
                .map((e) =>
                    ModuleProgress.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
