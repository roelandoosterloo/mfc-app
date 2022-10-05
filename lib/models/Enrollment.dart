/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Enrollment type in your schema. */
@immutable
class Enrollment extends Model {
  static const classType = const _EnrollmentModelType();
  final String id;
  final String? _owner;
  final TemporalDateTime? _enrolledAt;
  final TemporalDateTime? _startedAt;
  final TemporalDateTime? _completedAt;
  final Course? _course;
  final List<ModuleProgress>? _moduleSchedule;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String? get owner {
    return _owner;
  }
  
  TemporalDateTime? get enrolledAt {
    return _enrolledAt;
  }
  
  TemporalDateTime? get startedAt {
    return _startedAt;
  }
  
  TemporalDateTime? get completedAt {
    return _completedAt;
  }
  
  Course? get course {
    return _course;
  }
  
  List<ModuleProgress>? get moduleSchedule {
    return _moduleSchedule;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Enrollment._internal({required this.id, owner, enrolledAt, startedAt, completedAt, course, moduleSchedule, createdAt, updatedAt}): _owner = owner, _enrolledAt = enrolledAt, _startedAt = startedAt, _completedAt = completedAt, _course = course, _moduleSchedule = moduleSchedule, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Enrollment({String? id, String? owner, TemporalDateTime? enrolledAt, TemporalDateTime? startedAt, TemporalDateTime? completedAt, Course? course, List<ModuleProgress>? moduleSchedule}) {
    return Enrollment._internal(
      id: id == null ? UUID.getUUID() : id,
      owner: owner,
      enrolledAt: enrolledAt,
      startedAt: startedAt,
      completedAt: completedAt,
      course: course,
      moduleSchedule: moduleSchedule != null ? List<ModuleProgress>.unmodifiable(moduleSchedule) : moduleSchedule);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Enrollment &&
      id == other.id &&
      _owner == other._owner &&
      _enrolledAt == other._enrolledAt &&
      _startedAt == other._startedAt &&
      _completedAt == other._completedAt &&
      _course == other._course &&
      DeepCollectionEquality().equals(_moduleSchedule, other._moduleSchedule);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Enrollment {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("enrolledAt=" + (_enrolledAt != null ? _enrolledAt!.format() : "null") + ", ");
    buffer.write("startedAt=" + (_startedAt != null ? _startedAt!.format() : "null") + ", ");
    buffer.write("completedAt=" + (_completedAt != null ? _completedAt!.format() : "null") + ", ");
    buffer.write("course=" + (_course != null ? _course!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Enrollment copyWith({String? id, String? owner, TemporalDateTime? enrolledAt, TemporalDateTime? startedAt, TemporalDateTime? completedAt, Course? course, List<ModuleProgress>? moduleSchedule}) {
    return Enrollment._internal(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      enrolledAt: enrolledAt ?? this.enrolledAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      course: course ?? this.course,
      moduleSchedule: moduleSchedule ?? this.moduleSchedule);
  }
  
  Enrollment.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _owner = json['owner'],
      _enrolledAt = json['enrolledAt'] != null ? TemporalDateTime.fromString(json['enrolledAt']) : null,
      _startedAt = json['startedAt'] != null ? TemporalDateTime.fromString(json['startedAt']) : null,
      _completedAt = json['completedAt'] != null ? TemporalDateTime.fromString(json['completedAt']) : null,
      _course = json['course']?['serializedData'] != null
        ? Course.fromJson(new Map<String, dynamic>.from(json['course']['serializedData']))
        : null,
      _moduleSchedule = json['moduleSchedule'] is List
        ? (json['moduleSchedule'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ModuleProgress.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'owner': _owner, 'enrolledAt': _enrolledAt?.format(), 'startedAt': _startedAt?.format(), 'completedAt': _completedAt?.format(), 'course': _course?.toJson(), 'moduleSchedule': _moduleSchedule?.map((ModuleProgress? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField ENROLLEDAT = QueryField(fieldName: "enrolledAt");
  static final QueryField STARTEDAT = QueryField(fieldName: "startedAt");
  static final QueryField COMPLETEDAT = QueryField(fieldName: "completedAt");
  static final QueryField COURSE = QueryField(
    fieldName: "course",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Course).toString()));
  static final QueryField MODULESCHEDULE = QueryField(
    fieldName: "moduleSchedule",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ModuleProgress).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Enrollment";
    modelSchemaDefinition.pluralName = "Enrollments";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.GROUPS,
        groupClaim: "cognito:groups",
        groups: [ "admin" ],
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ]),
      AuthRule(
        authStrategy: AuthStrategy.OWNER,
        ownerField: "owner",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["courseId"], name: "ofCourse")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Enrollment.OWNER,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Enrollment.ENROLLEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Enrollment.STARTEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Enrollment.COMPLETEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Enrollment.COURSE,
      isRequired: false,
      targetName: "courseId",
      ofModelName: (Course).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Enrollment.MODULESCHEDULE,
      isRequired: true,
      ofModelName: (ModuleProgress).toString(),
      associatedKey: ModuleProgress.ENROLLMENTID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _EnrollmentModelType extends ModelType<Enrollment> {
  const _EnrollmentModelType();
  
  @override
  Enrollment fromJson(Map<String, dynamic> jsonData) {
    return Enrollment.fromJson(jsonData);
  }
}