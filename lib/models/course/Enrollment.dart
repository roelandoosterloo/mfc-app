import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/course/ModuleProgress.dart';

import 'Course.dart';

@immutable
class Enrollment extends Model {
  final String id;
  final DateTime? _startedAt;
  final DateTime? _enrolledAt;
  final DateTime? _completedAt;
  final Course _course;
  final List<ModuleProgress>? _moduleSchedule;

  @override
  String getId() {
    return id;
  }

  DateTime? get startedAt {
    return _startedAt;
  }

  DateTime? get enrolledAt {
    return _enrolledAt;
  }

  DateTime? get completedAt {
    return _completedAt;
  }

  Course get course {
    return _course;
  }

  List<ModuleProgress>? get moduleSchedule {
    return _moduleSchedule;
  }

  bool isCourseDone() {
    bool done = true;
    if (completedAt != null) return true;
    if (moduleSchedule == null) return true;
    moduleSchedule!.forEach((element) {
      done = done && element.completedAt != null;
    });
    return done;
  }

  const Enrollment._internal(
      {required this.id,
      startedAt,
      enrolledAt,
      completedAt,
      required course,
      moduleSchedule})
      : _startedAt = startedAt,
        _course = course,
        _enrolledAt = enrolledAt,
        _completedAt = completedAt,
        _moduleSchedule = moduleSchedule;

  factory Enrollment(
      {String? id,
      DateTime? startedAt,
      DateTime? enrolledAt,
      DateTime? completedAt,
      required Course course,
      List<ModuleProgress>? moduleSchedule}) {
    return Enrollment._internal(
      id: id == null ? UUID.getUUID() : id,
      startedAt: startedAt,
      enrolledAt: startedAt,
      completedAt: startedAt,
      course: course,
      moduleSchedule: moduleSchedule != null
          ? List<ModuleProgress>.unmodifiable(moduleSchedule)
          : null,
    );
  }

  Enrollment.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _startedAt = json['startedAt'] != null
            ? DateTime.parse(json['startedAt'])
            : null,
        _enrolledAt = json['enrolledAt'] != null
            ? DateTime.parse(json['enrolledAt'])
            : null,
        _completedAt = json['completedAt'] != null
            ? DateTime.parse(json['completedAt'])
            : null,
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

  @override
  bool operator ==(Object other) =>
      other is Enrollment &&
      id == other.id &&
      _startedAt == other.startedAt &&
      _enrolledAt == other.enrolledAt &&
      _completedAt == other.completedAt &&
      _course == other.course &&
      _moduleSchedule == other.moduleSchedule;

  @override
  int get hashCode => super.hashCode;
}
