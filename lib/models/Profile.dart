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

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the Profile type in your schema. */
@immutable
class Profile extends Model {
  static const classType = const _ProfileModelType();
  final String id;
  final String? _cognitoId;
  final String? _firstName;
  final String? _lastName;
  final String? _email;
  final TemporalDate? _birthDate;
  final double? _length;
  final double? _targetWeight;
  final String? _currentCourseId;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get cognitoId {
    try {
      return _cognitoId!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get firstName {
    return _firstName;
  }
  
  String? get lastName {
    return _lastName;
  }
  
  String? get email {
    return _email;
  }
  
  TemporalDate? get birthDate {
    return _birthDate;
  }
  
  double? get length {
    return _length;
  }
  
  double? get targetWeight {
    return _targetWeight;
  }
  
  String? get currentCourseId {
    return _currentCourseId;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Profile._internal({required this.id, required cognitoId, firstName, lastName, email, birthDate, length, targetWeight, currentCourseId, createdAt, updatedAt}): _cognitoId = cognitoId, _firstName = firstName, _lastName = lastName, _email = email, _birthDate = birthDate, _length = length, _targetWeight = targetWeight, _currentCourseId = currentCourseId, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Profile({String? id, required String cognitoId, String? firstName, String? lastName, String? email, TemporalDate? birthDate, double? length, double? targetWeight, String? currentCourseId}) {
    return Profile._internal(
      id: id == null ? UUID.getUUID() : id,
      cognitoId: cognitoId,
      firstName: firstName,
      lastName: lastName,
      email: email,
      birthDate: birthDate,
      length: length,
      targetWeight: targetWeight,
      currentCourseId: currentCourseId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
      id == other.id &&
      _cognitoId == other._cognitoId &&
      _firstName == other._firstName &&
      _lastName == other._lastName &&
      _email == other._email &&
      _birthDate == other._birthDate &&
      _length == other._length &&
      _targetWeight == other._targetWeight &&
      _currentCourseId == other._currentCourseId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Profile {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("cognitoId=" + "$_cognitoId" + ", ");
    buffer.write("firstName=" + "$_firstName" + ", ");
    buffer.write("lastName=" + "$_lastName" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("birthDate=" + (_birthDate != null ? _birthDate!.format() : "null") + ", ");
    buffer.write("length=" + (_length != null ? _length!.toString() : "null") + ", ");
    buffer.write("targetWeight=" + (_targetWeight != null ? _targetWeight!.toString() : "null") + ", ");
    buffer.write("currentCourseId=" + "$_currentCourseId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Profile copyWith({String? id, String? cognitoId, String? firstName, String? lastName, String? email, TemporalDate? birthDate, double? length, double? targetWeight, String? currentCourseId}) {
    return Profile._internal(
      id: id ?? this.id,
      cognitoId: cognitoId ?? this.cognitoId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birthDate: birthDate ?? this.birthDate,
      length: length ?? this.length,
      targetWeight: targetWeight ?? this.targetWeight,
      currentCourseId: currentCourseId ?? this.currentCourseId);
  }
  
  Profile.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _cognitoId = json['cognitoId'],
      _firstName = json['firstName'],
      _lastName = json['lastName'],
      _email = json['email'],
      _birthDate = json['birthDate'] != null ? TemporalDate.fromString(json['birthDate']) : null,
      _length = (json['length'] as num?)?.toDouble(),
      _targetWeight = (json['targetWeight'] as num?)?.toDouble(),
      _currentCourseId = json['currentCourseId'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'cognitoId': _cognitoId, 'firstName': _firstName, 'lastName': _lastName, 'email': _email, 'birthDate': _birthDate?.format(), 'length': _length, 'targetWeight': _targetWeight, 'currentCourseId': _currentCourseId, 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField COGNITOID = QueryField(fieldName: "cognitoId");
  static final QueryField FIRSTNAME = QueryField(fieldName: "firstName");
  static final QueryField LASTNAME = QueryField(fieldName: "lastName");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField BIRTHDATE = QueryField(fieldName: "birthDate");
  static final QueryField LENGTH = QueryField(fieldName: "length");
  static final QueryField TARGETWEIGHT = QueryField(fieldName: "targetWeight");
  static final QueryField CURRENTCOURSEID = QueryField(fieldName: "currentCourseId");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Profile";
    modelSchemaDefinition.pluralName = "Profiles";
    
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
        authStrategy: AuthStrategy.OWNER,
        ownerField: "cognitoId",
        identityClaim: "cognito:username",
        provider: AuthRuleProvider.USERPOOLS,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.COGNITOID,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.FIRSTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.LASTNAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.EMAIL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.BIRTHDATE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.LENGTH,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.TARGETWEIGHT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Profile.CURRENTCOURSEID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
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

class _ProfileModelType extends ModelType<Profile> {
  const _ProfileModelType();
  
  @override
  Profile fromJson(Map<String, dynamic> jsonData) {
    return Profile.fromJson(jsonData);
  }
}