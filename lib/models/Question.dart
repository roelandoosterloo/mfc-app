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


/** This is an auto generated class representing the Question type in your schema. */
@immutable
class Question extends Model {
  static const classType = const _QuestionModelType();
  final String id;
  final String? _moduleId;
  final int? _index;
  final QuestionType? _type;
  final String? _question;
  final String? _introduction;
  final List<Option>? _options;
  final Answer? _answer;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get moduleId {
    try {
      return _moduleId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get index {
    try {
      return _index!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  QuestionType get type {
    try {
      return _type!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get question {
    try {
      return _question!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get introduction {
    return _introduction;
  }
  
  List<Option>? get options {
    return _options;
  }
  
  Answer? get answer {
    return _answer;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Question._internal({required this.id, required moduleId, required index, required type, required question, introduction, options, answer, createdAt, updatedAt}): _moduleId = moduleId, _index = index, _type = type, _question = question, _introduction = introduction, _options = options, _answer = answer, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Question({String? id, required String moduleId, required int index, required QuestionType type, required String question, String? introduction, List<Option>? options, Answer? answer}) {
    return Question._internal(
      id: id == null ? UUID.getUUID() : id,
      moduleId: moduleId,
      index: index,
      type: type,
      question: question,
      introduction: introduction,
      options: options != null ? List<Option>.unmodifiable(options) : options,
      answer: answer);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Question &&
      id == other.id &&
      _moduleId == other._moduleId &&
      _index == other._index &&
      _type == other._type &&
      _question == other._question &&
      _introduction == other._introduction &&
      DeepCollectionEquality().equals(_options, other._options) &&
      _answer == other._answer;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Question {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("moduleId=" + "$_moduleId" + ", ");
    buffer.write("index=" + (_index != null ? _index!.toString() : "null") + ", ");
    buffer.write("type=" + (_type != null ? enumToString(_type)! : "null") + ", ");
    buffer.write("question=" + "$_question" + ", ");
    buffer.write("introduction=" + "$_introduction" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Question copyWith({String? id, String? moduleId, int? index, QuestionType? type, String? question, String? introduction, List<Option>? options, Answer? answer}) {
    return Question._internal(
      id: id ?? this.id,
      moduleId: moduleId ?? this.moduleId,
      index: index ?? this.index,
      type: type ?? this.type,
      question: question ?? this.question,
      introduction: introduction ?? this.introduction,
      options: options ?? this.options,
      answer: answer ?? this.answer);
  }
  
  Question.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _moduleId = json['moduleId'],
      _index = (json['index'] as num?)?.toInt(),
      _type = enumFromString<QuestionType>(json['type'], QuestionType.values),
      _question = json['question'],
      _introduction = json['introduction'],
      _options = json['options'] is List
        ? (json['options'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Option.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _answer = json['answer']?['serializedData'] != null
        ? Answer.fromJson(new Map<String, dynamic>.from(json['answer']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'moduleId': _moduleId, 'index': _index, 'type': enumToString(_type), 'question': _question, 'introduction': _introduction, 'options': _options?.map((Option? e) => e?.toJson()).toList(), 'answer': _answer?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField MODULEID = QueryField(fieldName: "moduleId");
  static final QueryField INDEX = QueryField(fieldName: "index");
  static final QueryField TYPE = QueryField(fieldName: "type");
  static final QueryField QUESTION = QueryField(fieldName: "question");
  static final QueryField INTRODUCTION = QueryField(fieldName: "introduction");
  static final QueryField OPTIONS = QueryField(
    fieldName: "options",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Option).toString()));
  static final QueryField ANSWER = QueryField(
    fieldName: "answer",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Answer).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Question";
    modelSchemaDefinition.pluralName = "Questions";
    
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
      ModelIndex(fields: const ["moduleId"], name: "ofModule")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Question.MODULEID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Question.INDEX,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Question.TYPE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Question.QUESTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Question.INTRODUCTION,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Question.OPTIONS,
      isRequired: true,
      ofModelName: (Option).toString(),
      associatedKey: Option.QUESTIONID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasOne(
      key: Question.ANSWER,
      isRequired: false,
      ofModelName: (Answer).toString(),
      associatedKey: Answer.ID
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

class _QuestionModelType extends ModelType<Question> {
  const _QuestionModelType();
  
  @override
  Question fromJson(Map<String, dynamic> jsonData) {
    return Question.fromJson(jsonData);
  }
}