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

/** This is an auto generated class representing the ModuleProgress type in your schema. */
@immutable
class ModuleProgress extends Model {
  static const classType = const _ModuleProgressModelType();
  final String id;
  final String? _enrollmentId;
  final String? _owner;
  final TemporalDateTime? _availableAt;
  final TemporalDateTime? _startedAt;
  final TemporalDateTime? _completedAt;
  final Module? _module;
  final List<Answer>? _workbook;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;

  @override
  String getId() {
    return id;
  }

  String get enrollmentId {
    try {
      return _enrollmentId!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  String get owner {
    try {
      return _owner!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  TemporalDateTime get availableAt {
    try {
      return _availableAt!;
    } catch (e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion: AmplifyExceptionMessages
              .codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString());
    }
  }

  TemporalDateTime? get startedAt {
    return _startedAt;
  }

  TemporalDateTime? get completedAt {
    return _completedAt;
  }

  Module? get module {
    return _module;
  }

  List<Answer>? get workbook {
    return _workbook;
  }

  TemporalDateTime? get createdAt {
    return _createdAt;
  }

  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }

  const ModuleProgress._internal(
      {required this.id,
      required enrollmentId,
      required owner,
      required availableAt,
      startedAt,
      completedAt,
      module,
      workbook,
      createdAt,
      updatedAt})
      : _enrollmentId = enrollmentId,
        _owner = owner,
        _availableAt = availableAt,
        _startedAt = startedAt,
        _completedAt = completedAt,
        _module = module,
        _workbook = workbook,
        _createdAt = createdAt,
        _updatedAt = updatedAt;

  factory ModuleProgress(
      {String? id,
      required String enrollmentId,
      required String owner,
      required TemporalDateTime availableAt,
      TemporalDateTime? startedAt,
      TemporalDateTime? completedAt,
      Module? module,
      List<Answer>? workbook}) {
    return ModuleProgress._internal(
        id: id == null ? UUID.getUUID() : id,
        enrollmentId: enrollmentId,
        owner: owner,
        availableAt: availableAt,
        startedAt: startedAt,
        completedAt: completedAt,
        module: module,
        workbook:
            workbook != null ? List<Answer>.unmodifiable(workbook) : workbook);
  }

  bool equals(Object other) {
    return this == other;
  }

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModuleProgress &&
        id == other.id &&
        _enrollmentId == other._enrollmentId &&
        _owner == other._owner &&
        _availableAt == other._availableAt &&
        _startedAt == other._startedAt &&
        _completedAt == other._completedAt &&
        _module == other._module &&
        DeepCollectionEquality().equals(_workbook, other._workbook);
  }

  @override
  int get hashCode => toString().hashCode;

  @override
  String toString() {
    var buffer = new StringBuffer();

    buffer.write("ModuleProgress {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("enrollmentId=" + "$_enrollmentId" + ", ");
    buffer.write("owner=" + "$_owner" + ", ");
    buffer.write("availableAt=" +
        (_availableAt != null ? _availableAt!.format() : "null") +
        ", ");
    buffer.write("startedAt=" +
        (_startedAt != null ? _startedAt!.format() : "null") +
        ", ");
    buffer.write("completedAt=" +
        (_completedAt != null ? _completedAt!.format() : "null") +
        ", ");
    buffer.write(
        "module=" + (_module != null ? _module!.toString() : "null") + ", ");
    buffer.write("createdAt=" +
        (_createdAt != null ? _createdAt!.format() : "null") +
        ", ");
    buffer.write(
        "updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");

    return buffer.toString();
  }

  ModuleProgress copyWith(
      {String? id,
      String? enrollmentId,
      String? owner,
      TemporalDateTime? availableAt,
      TemporalDateTime? startedAt,
      TemporalDateTime? completedAt,
      Module? module,
      List<Answer>? workbook}) {
    return ModuleProgress._internal(
        id: id ?? this.id,
        enrollmentId: enrollmentId ?? this.enrollmentId,
        owner: owner ?? this.owner,
        availableAt: availableAt ?? this.availableAt,
        startedAt: startedAt ?? this.startedAt,
        completedAt: completedAt ?? this.completedAt,
        module: module ?? this.module,
        workbook: workbook ?? this.workbook);
  }

  ModuleProgress.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _enrollmentId = json['enrollmentId'],
        _owner = json['owner'],
        _availableAt = json['availableAt'] != null
            ? TemporalDateTime.fromString(json['availableAt'])
            : null,
        _startedAt = json['startedAt'] != null
            ? TemporalDateTime.fromString(json['startedAt'])
            : null,
        _completedAt = json['completedAt'] != null
            ? TemporalDateTime.fromString(json['completedAt'])
            : null,
        _module = json['module']?['serializedData'] != null
            ? Module.fromJson(
                new Map<String, dynamic>.from(json['module']['serializedData']))
            : null,
        _workbook = json['workbook'] is List
            ? (json['workbook'] as List)
                .where((e) => e?['serializedData'] != null)
                .map((e) => Answer.fromJson(
                    new Map<String, dynamic>.from(e['serializedData'])))
                .toList()
            : null,
        _createdAt = json['createdAt'] != null
            ? TemporalDateTime.fromString(json['createdAt'])
            : null,
        _updatedAt = json['updatedAt'] != null
            ? TemporalDateTime.fromString(json['updatedAt'])
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'enrollmentId': _enrollmentId,
        'owner': _owner,
        'availableAt': _availableAt?.format(),
        'startedAt': _startedAt?.format(),
        'completedAt': _completedAt?.format(),
        'module': _module?.toJson(),
        'workbook': _workbook?.map((Answer? e) => e?.toJson()).toList(),
        'createdAt': _createdAt?.format(),
        'updatedAt': _updatedAt?.format()
      };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField ENROLLMENTID = QueryField(fieldName: "enrollmentId");
  static final QueryField OWNER = QueryField(fieldName: "owner");
  static final QueryField AVAILABLEAT = QueryField(fieldName: "availableAt");
  static final QueryField STARTEDAT = QueryField(fieldName: "startedAt");
  static final QueryField COMPLETEDAT = QueryField(fieldName: "completedAt");
  static final QueryField MODULE = QueryField(
      fieldName: "module",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Module).toString()));
  static final QueryField WORKBOOK = QueryField(
      fieldName: "workbook",
      fieldType: ModelFieldType(ModelFieldTypeEnum.model,
          ofModelName: (Answer).toString()));
  static var schema =
      Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "ModuleProgress";
    modelSchemaDefinition.pluralName = "ModuleProgresses";

    modelSchemaDefinition.authRules = [
      AuthRule(
          authStrategy: AuthStrategy.GROUPS,
          groupClaim: "cognito:groups",
          groups: ["admin"],
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
          authStrategy: AuthStrategy.PRIVATE, operations: [ModelOperation.READ])
    ];

    modelSchemaDefinition.indexes = [
      ModelIndex(fields: const ["enrollmentId"], name: "ofEnrollment"),
      ModelIndex(fields: const ["moduleId"], name: "moduleId")
    ];

    modelSchemaDefinition.addField(ModelFieldDefinition.id());

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ModuleProgress.ENROLLMENTID,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ModuleProgress.OWNER,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.string)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ModuleProgress.AVAILABLEAT,
        isRequired: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ModuleProgress.STARTEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.field(
        key: ModuleProgress.COMPLETEDAT,
        isRequired: false,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
        key: ModuleProgress.MODULE,
        isRequired: false,
        targetName: "moduleId",
        ofModelName: (Module).toString()));

    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
        key: ModuleProgress.WORKBOOK,
        isRequired: false,
        ofModelName: (Answer).toString(),
        associatedKey: Answer.MODULEPROGRESSID));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'createdAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));

    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
        fieldName: 'updatedAt',
        isRequired: false,
        isReadOnly: true,
        ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)));
  });
}

class _ModuleProgressModelType extends ModelType<ModuleProgress> {
  const _ModuleProgressModelType();

  @override
  ModuleProgress fromJson(Map<String, dynamic> jsonData) {
    return ModuleProgress.fromJson(jsonData);
  }
}
