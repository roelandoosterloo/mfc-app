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


/** This is an auto generated class representing the CognitoGroup type in your schema. */
@immutable
class CognitoGroup {
  final String? _GroupName;
  final String? _Description;
  final int? _Precedence;
  final String? _LastMOdifiedDate;
  final String? _CreationDate;

  String? get GroupName {
    return _GroupName;
  }
  
  String? get Description {
    return _Description;
  }
  
  int? get Precedence {
    return _Precedence;
  }
  
  String? get LastMOdifiedDate {
    return _LastMOdifiedDate;
  }
  
  String? get CreationDate {
    return _CreationDate;
  }
  
  const CognitoGroup._internal({GroupName, Description, Precedence, LastMOdifiedDate, CreationDate}): _GroupName = GroupName, _Description = Description, _Precedence = Precedence, _LastMOdifiedDate = LastMOdifiedDate, _CreationDate = CreationDate;
  
  factory CognitoGroup({String? GroupName, String? Description, int? Precedence, String? LastMOdifiedDate, String? CreationDate}) {
    return CognitoGroup._internal(
      GroupName: GroupName,
      Description: Description,
      Precedence: Precedence,
      LastMOdifiedDate: LastMOdifiedDate,
      CreationDate: CreationDate);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CognitoGroup &&
      _GroupName == other._GroupName &&
      _Description == other._Description &&
      _Precedence == other._Precedence &&
      _LastMOdifiedDate == other._LastMOdifiedDate &&
      _CreationDate == other._CreationDate;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("CognitoGroup {");
    buffer.write("GroupName=" + "$_GroupName" + ", ");
    buffer.write("Description=" + "$_Description" + ", ");
    buffer.write("Precedence=" + (_Precedence != null ? _Precedence!.toString() : "null") + ", ");
    buffer.write("LastMOdifiedDate=" + "$_LastMOdifiedDate" + ", ");
    buffer.write("CreationDate=" + "$_CreationDate");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  CognitoGroup copyWith({String? GroupName, String? Description, int? Precedence, String? LastMOdifiedDate, String? CreationDate}) {
    return CognitoGroup._internal(
      GroupName: GroupName ?? this.GroupName,
      Description: Description ?? this.Description,
      Precedence: Precedence ?? this.Precedence,
      LastMOdifiedDate: LastMOdifiedDate ?? this.LastMOdifiedDate,
      CreationDate: CreationDate ?? this.CreationDate);
  }
  
  CognitoGroup.fromJson(Map<String, dynamic> json)  
    : _GroupName = json['GroupName'],
      _Description = json['Description'],
      _Precedence = (json['Precedence'] as num?)?.toInt(),
      _LastMOdifiedDate = json['LastMOdifiedDate'],
      _CreationDate = json['CreationDate'];
  
  Map<String, dynamic> toJson() => {
    'GroupName': _GroupName, 'Description': _Description, 'Precedence': _Precedence, 'LastMOdifiedDate': _LastMOdifiedDate, 'CreationDate': _CreationDate
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "CognitoGroup";
    modelSchemaDefinition.pluralName = "CognitoGroups";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'GroupName',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'Description',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'Precedence',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'LastMOdifiedDate',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'CreationDate',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}