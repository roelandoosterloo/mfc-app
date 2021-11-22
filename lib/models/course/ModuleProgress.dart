import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/foundation.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/course/Answer.dart';
import 'package:mfc_app/models/course/Module.dart';

@immutable
class ModuleProgress extends Model {
  final String id;
  final DateTime _availableAt;
  final Module? _module;
  final List<Answer>? _workbook;

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

  List<Answer>? get workbook {
    return _workbook;
  }

  bool isAvailable() {
    return _availableAt.isBefore(DateTime.now());
  }

  const ModuleProgress._internal({
    required this.id,
    required availableAt,
    module,
    workbook,
  })  : _availableAt = availableAt,
        _module = module,
        _workbook = workbook;

  factory ModuleProgress({
    String? id,
    required DateTime availableAt,
    Module? module,
    List<Answer>? workbook,
  }) {
    return ModuleProgress._internal(
      id: id == null ? UUID.getUUID() : id,
      availableAt: availableAt,
      module: module,
      workbook: workbook,
    );
  }

  ModuleProgress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _availableAt = DateTime.parse(json['availableAt']),
        _module = Module.fromJson(json['module']),
        _workbook = json['workbook']?['items'] is List
            ? (json['workbook']['items'] as List)
                .map((e) => Answer.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
