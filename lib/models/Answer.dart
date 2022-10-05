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


/** This is an auto generated class representing the Answer type in your schema. */
@immutable
class Answer extends Model {
  static const classType = const _AnswerModelType();
  final String id;
  final String? _moduleProgressId;
  final String? _answer;
  final Question? _question;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get moduleProgressId {
    try {
      return _moduleProgressId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get answer {
    try {
      return _answer!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  Question? get question {
    return _question;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Answer._internal({required this.id, required moduleProgressId, required answer, question, createdAt, updatedAt}): _moduleProgressId = moduleProgressId, _answer = answer, _question = question, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Answer({String? id, required String moduleProgressId, required String answer, Question? question}) {
    return Answer._internal(
      id: id == null ? UUID.getUUID() : id,
      moduleProgressId: moduleProgressId,
      answer: answer,
      question: question);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Answer &&
      id == other.id &&
      _moduleProgressId == other._moduleProgressId &&
      _answer == other._answer &&
      _question == other._question;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Answer {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("moduleProgressId=" + "$_moduleProgressId" + ", ");
    buffer.write("answer=" + "$_answer" + ", ");
    buffer.write("question=" + (_question != null ? _question!.toString() : "null") + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Answer copyWith({String? id, String? moduleProgressId, String? answer, Question? question}) {
    return Answer._internal(
      id: id ?? this.id,
      moduleProgressId: moduleProgressId ?? this.moduleProgressId,
      answer: answer ?? this.answer,
      question: question ?? this.question);
  }
  
  Answer.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _moduleProgressId = json['moduleProgressId'],
      _answer = json['answer'],
      _question = json['question']?['serializedData'] != null
        ? Question.fromJson(new Map<String, dynamic>.from(json['question']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'moduleProgressId': _moduleProgressId, 'answer': _answer, 'question': _question?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField MODULEPROGRESSID = QueryField(fieldName: "moduleProgressId");
  static final QueryField ANSWER = QueryField(fieldName: "answer");
  static final QueryField QUESTION = QueryField(
    fieldName: "question",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Question).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Answer";
    modelSchemaDefinition.pluralName = "Answers";
    
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
      ModelIndex(fields: const ["questionId"], name: "ofQuestion"),
      ModelIndex(fields: const ["moduleProgressId"], name: "ofWorkbook")
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Answer.MODULEPROGRESSID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Answer.ANSWER,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.belongsTo(
      key: Answer.QUESTION,
      isRequired: false,
      targetName: "questionId",
      ofModelName: (Question).toString()
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

class _AnswerModelType extends ModelType<Answer> {
  const _AnswerModelType();
  
  @override
  Answer fromJson(Map<String, dynamic> jsonData) {
    return Answer.fromJson(jsonData);
  }
}