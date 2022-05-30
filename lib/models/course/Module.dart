import 'package:amplify_flutter/amplify_flutter.dart' as amplify;
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

import 'Question.dart';

@immutable
class Module extends Model {
  final String id;
  final String _courseId;
  final String _name;
  final int? _index;
  final String _description;
  final String? _coverImage;
  final String _videoUrl;
  final int _delayNumber;
  final String _delayUOM;
  final List<Question>? _assignments;

  @override
  String getId() {
    return id;
  }

  String get courseId {
    return _courseId;
  }

  String get name {
    return _name;
  }

  int? get index {
    return _index;
  }

  String get description {
    return _description;
  }

  String? get coverImage {
    return _coverImage;
  }

  String get videoUrl {
    return _videoUrl;
  }

  int get delayNumber {
    return _delayNumber;
  }

  String get delayUOM {
    return _delayUOM;
  }

  List<Question>? get assignments {
    return _assignments;
  }

  const Module._internal(
      {required this.id,
      required courseId,
      required name,
      index,
      description,
      coverImage,
      required videoUrl,
      required delayNumber,
      required delayUOM,
      assignments})
      : _courseId = courseId,
        _name = name,
        _index = index,
        _description = description,
        _coverImage = coverImage,
        _videoUrl = videoUrl,
        _delayNumber = delayNumber,
        _delayUOM = delayUOM,
        _assignments = assignments;

  factory Module(
      {String? id,
      required String courseId,
      required String name,
      int? index,
      String? description,
      String? coverImage,
      required String videoUrl,
      required int delayNumber,
      required String delayUOM,
      List<Question>? assignments}) {
    return Module._internal(
        id: id == null ? amplify.UUID.getUUID() : id,
        courseId: courseId,
        name: name,
        index: index,
        description: description,
        coverImage: coverImage,
        videoUrl: videoUrl,
        delayNumber: delayNumber,
        delayUOM: delayUOM,
        assignments: assignments != null
            ? List<Question>.unmodifiable(
                assignments..sort(((a, b) => a.index.compareTo(b.index))))
            : assignments);
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Module {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("courseId=" + "$_courseId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write(
        "index=" + (_index != null ? _index!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("coverImage=" + "$_coverImage" + ", ");
    buffer.write("videoUrl=" + "$_videoUrl");
    buffer.write("}");

    return buffer.toString();
  }

  Module.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _courseId = json['courseId'],
        _name = json['name'],
        _index = json['index'],
        _description = json['description'],
        _coverImage = json['coverImage'],
        _videoUrl = json['videoUrl'],
        _delayNumber = json['delayNumber'],
        _delayUOM = json['delayUOM'],
        _assignments = json['assignments']?["items"] is List
            ? (json['assignments']["items"] as List)
                .map((e) => Question.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null {
    if (_assignments != null)
      _assignments!.sort(((a, b) => a.index.compareTo(b.index)));
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseId': _courseId,
        'name': _name,
        'index': _index,
        'description': _description,
        'coverImage': _coverImage,
        'videoUrl': _videoUrl,
        'delayNumber': _delayNumber,
        'delayUOM': _delayUOM,
        'assignments': _assignments?.map((e) => e.toJson()).toList()
      };

  @override
  bool operator ==(Object other) =>
      other is Module &&
      id == other.id &&
      _courseId == other.courseId &&
      _name == other.name &&
      _index == other.index &&
      _description == other.description &&
      _coverImage == other.coverImage &&
      _videoUrl == other.videoUrl &&
      _delayNumber == other.delayNumber &&
      _delayUOM == other.delayUOM &&
      _assignments == other.assignments;

  @override
  int get hashCode => super.hashCode;
}
