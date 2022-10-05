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
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the ProgramCourse type in your schema. */
@immutable
class ProgramCourse extends Model {
  static const classType = const _ProgramCourseModelType();
  final String id;
  final Course? _course;
  final Program? _program;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  Course get course {
    try {
      return _course!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Program get program {
    try {
      return _program!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const ProgramCourse._internal({required this.id, required course, required program, createdAt, updatedAt}): _course = course, _program = program, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory ProgramCourse({String? id, required Course course, required Program program}) {
    return ProgramCourse._internal(
      id: id == null ? UUID.getUUID() : id,
      course: course,
      program: program);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgramCourse &&
      id == other.id &&
      _course == other._course &&
      _program == other._program;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("ProgramCourse {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("course=" + (_course != null ? _course!.toString() : "null") + ", ");
    buffer.write("program=" + (_program != null ? _program!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  ProgramCourse copyWith({String? id, Course? course, Program? program}) {
    return ProgramCourse._internal(
      id: id ?? this.id,
      course: course ?? this.course,
      program: program ?? this.program);
  }
  
  ProgramCourse.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _course = json['course']?['serializedData'] != null
        ? Course.fromJson(new Map<String, dynamic>.from(json['course']['serializedData']))
        : null,
      _program = json['program']?['serializedData'] != null
        ? Program.fromJson(new Map<String, dynamic>.from(json['program']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'course': _course?.toJson(), 'program': _program?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField COURSE = QueryField(
    fieldName: "course",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Course).toString()));
  static final QueryField PROGRAM = QueryField(
    fieldName: "program",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Program).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ProgramCourse";
    modelSchemaDefinition.pluralName = "ProgramCourses";
    
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
        authStrategy: AuthStrategy.PRIVATE,
        operations: [
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["programId", "courseId"], name: "byProgram"),
      ModelIndex(fields: const ["courseId", "programId"], name: "byCourse")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ProgramCourse.COURSE,
      isRequired: true,
      targetName: "courseId",
      ofModelName: (Course).toString()
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: ProgramCourse.PROGRAM,
      isRequired: true,
      targetName: "programId",
      ofModelName: (Program).toString()
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

class _ProgramCourseModelType extends ModelType<ProgramCourse> {
  const _ProgramCourseModelType();
  
  @override
  ProgramCourse fromJson(Map<String, dynamic> jsonData) {
    return ProgramCourse.fromJson(jsonData);
  }
}