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


/** This is an auto generated class representing the Module type in your schema. */
@immutable
class Module extends Model {
  static const classType = const _ModuleModelType();
  final String id;
  final String? _courseId;
  final String? _name;
  final int? _index;
  final String? _description;
  final String? _coverImage;
  final String? _videoUrl;
  final int? _delayNumber;
  final String? _delayUOM;
  final List<Question>? _assignments;
  final List<Downloadable>? _tools;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get courseId {
    try {
      return _courseId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get name {
    try {
      return _name!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int? get index {
    return _index;
  }
  
  String get description {
    try {
      return _description!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get coverImage {
    return _coverImage;
  }
  
  String get videoUrl {
    try {
      return _videoUrl!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get delayNumber {
    try {
      return _delayNumber!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get delayUOM {
    try {
      return _delayUOM!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Question>? get assignments {
    return _assignments;
  }
  
  List<Downloadable>? get tools {
    return _tools;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Module._internal({required this.id, required courseId, required name, index, required description, coverImage, required videoUrl, required delayNumber, required delayUOM, assignments, tools, createdAt, updatedAt}): _courseId = courseId, _name = name, _index = index, _description = description, _coverImage = coverImage, _videoUrl = videoUrl, _delayNumber = delayNumber, _delayUOM = delayUOM, _assignments = assignments, _tools = tools, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Module({String? id, required String courseId, required String name, int? index, required String description, String? coverImage, required String videoUrl, required int delayNumber, required String delayUOM, List<Question>? assignments, List<Downloadable>? tools}) {
    return Module._internal(
      id: id == null ? UUID.getUUID() : id,
      courseId: courseId,
      name: name,
      index: index,
      description: description,
      coverImage: coverImage,
      videoUrl: videoUrl,
      delayNumber: delayNumber,
      delayUOM: delayUOM,
      assignments: assignments != null ? List<Question>.unmodifiable(assignments) : assignments,
      tools: tools != null ? List<Downloadable>.unmodifiable(tools) : tools);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Module &&
      id == other.id &&
      _courseId == other._courseId &&
      _name == other._name &&
      _index == other._index &&
      _description == other._description &&
      _coverImage == other._coverImage &&
      _videoUrl == other._videoUrl &&
      _delayNumber == other._delayNumber &&
      _delayUOM == other._delayUOM &&
      DeepCollectionEquality().equals(_assignments, other._assignments) &&
      DeepCollectionEquality().equals(_tools, other._tools);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Module {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("courseId=" + "$_courseId" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("index=" + (_index != null ? _index!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("coverImage=" + "$_coverImage" + ", ");
    buffer.write("videoUrl=" + "$_videoUrl" + ", ");
    buffer.write("delayNumber=" + (_delayNumber != null ? _delayNumber!.toString() : "null") + ", ");
    buffer.write("delayUOM=" + "$_delayUOM" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Module copyWith({String? id, String? courseId, String? name, int? index, String? description, String? coverImage, String? videoUrl, int? delayNumber, String? delayUOM, List<Question>? assignments, List<Downloadable>? tools}) {
    return Module._internal(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      name: name ?? this.name,
      index: index ?? this.index,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      videoUrl: videoUrl ?? this.videoUrl,
      delayNumber: delayNumber ?? this.delayNumber,
      delayUOM: delayUOM ?? this.delayUOM,
      assignments: assignments ?? this.assignments,
      tools: tools ?? this.tools);
  }
  
  Module.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _courseId = json['courseId'],
      _name = json['name'],
      _index = (json['index'] as num?)?.toInt(),
      _description = json['description'],
      _coverImage = json['coverImage'],
      _videoUrl = json['videoUrl'],
      _delayNumber = (json['delayNumber'] as num?)?.toInt(),
      _delayUOM = json['delayUOM'],
      _assignments = json['assignments'] is List
        ? (json['assignments'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Question.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _tools = json['tools'] is List
        ? (json['tools'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Downloadable.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'courseId': _courseId, 'name': _name, 'index': _index, 'description': _description, 'coverImage': _coverImage, 'videoUrl': _videoUrl, 'delayNumber': _delayNumber, 'delayUOM': _delayUOM, 'assignments': _assignments?.map((Question? e) => e?.toJson()).toList(), 'tools': _tools?.map((Downloadable? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField COURSEID = QueryField(fieldName: "courseId");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField INDEX = QueryField(fieldName: "index");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField COVERIMAGE = QueryField(fieldName: "coverImage");
  static final QueryField VIDEOURL = QueryField(fieldName: "videoUrl");
  static final QueryField DELAYNUMBER = QueryField(fieldName: "delayNumber");
  static final QueryField DELAYUOM = QueryField(fieldName: "delayUOM");
  static final QueryField ASSIGNMENTS = QueryField(
    fieldName: "assignments",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Question).toString()));
  static final QueryField TOOLS = QueryField(
    fieldName: "tools",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Downloadable).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Module";
    modelSchemaDefinition.pluralName = "Modules";
    
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
        provider: AuthRuleProvider.IAM,
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
      ModelIndex(fields: const ["courseId"], name: "ofCourse")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.COURSEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.INDEX,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.COVERIMAGE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.VIDEOURL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.DELAYNUMBER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Module.DELAYUOM,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Module.ASSIGNMENTS,
      isRequired: true,
      ofModelName: (Question).toString(),
      associatedKey: Question.MODULEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Module.TOOLS,
      isRequired: true,
      ofModelName: (Downloadable).toString(),
      associatedKey: Downloadable.MODULEID
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

class _ModuleModelType extends ModelType<Module> {
  const _ModuleModelType();
  
  @override
  Module fromJson(Map<String, dynamic> jsonData) {
    return Module.fromJson(jsonData);
  }
}