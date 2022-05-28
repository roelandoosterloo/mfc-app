import 'dart:math';

import 'package:amplify_flutter/amplify_flutter.dart' as amplify;
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';

import 'Module.dart';

@immutable
class Course extends Model {
  final String id;
  final String _name;
  final String? _description;
  final String? _coverImage;
  final List<Module>? _modules;

  @override
  String getId() {
    return id;
  }

  String get name {
    return _name;
  }

  String? get description {
    return _description;
  }

  String? get coverImage {
    return _coverImage;
  }

  List<Module>? get modules {
    return _modules;
  }

  const Course._internal(
      {required this.id, required name, description, coverImage, modules})
      : _name = name,
        _description = description,
        _coverImage = coverImage,
        _modules = modules;

  factory Course(
      {String? id,
      required String name,
      String? description,
      String? coverImage,
      List<Module>? modules}) {
    return Course._internal(
        id: id == null ? amplify.UUID.getUUID() : id,
        name: name,
        description: description,
        coverImage: coverImage,
        modules:
            modules != null ? List<Module>.unmodifiable(modules) : modules);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("Course {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("description=" +
        "${_description?.substring(0, min(
              10,
              description?.length ?? 10,
            ))}" +
        ", ");
    buffer.write("coverImage=" + "$_coverImage");
    buffer.write("}");

    return buffer.toString();
  }

  Course.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = json['name'],
        _description = json['description'],
        _coverImage = json['coverImage'],
        _modules = json['modules']?['items'] is List
            ? (json['modules']['items'] as List)
                .map((e) => Module.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': _name,
        'description': _description,
        'coverImage': _coverImage,
        'modules': _modules?.map((e) => e.toJson()).toList()
      };

  @override
  bool operator ==(Object other) =>
      other is Course &&
      id == other.id &&
      _name == other.name &&
      _description == other.description &&
      _coverImage == other.coverImage &&
      _modules == other.modules;

  @override
  int get hashCode => super.hashCode;
}
