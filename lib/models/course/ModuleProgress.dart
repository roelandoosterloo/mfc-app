import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/course/Module.dart';

@immutable
class ModuleProgress extends Model {
  final String id;
  final DateTime _availableAt;
  final Module? _module;

  @override
  String getId() {
    return id;
  }

  DateTime get availableAt {
    return _availableAt;
  }

  Module? get module {
    return _module;
  }

  bool isAvailable() {
    return _availableAt.isBefore(DateTime.now());
  }

  const ModuleProgress._internal(
      {required this.id, required availableAt, module})
      : _availableAt = availableAt,
        _module = module;

  factory ModuleProgress(
      {String? id, required DateTime availableAt, Module? module}) {
    return ModuleProgress._internal(
        id: id == null ? UUID.getUUID() : id,
        availableAt: availableAt,
        module: module);
  }

  ModuleProgress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _availableAt = DateTime.parse(json['availableAt']),
        _module = Module.fromJson(json['module']);

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
