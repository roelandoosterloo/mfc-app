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


/** This is an auto generated class representing the MFAOption type in your schema. */
@immutable
class MFAOption {
  final String? _DeliveryMedium;
  final String? _AttributeName;

  String? get DeliveryMedium {
    return _DeliveryMedium;
  }
  
  String? get AttributeName {
    return _AttributeName;
  }
  
  const MFAOption._internal({DeliveryMedium, AttributeName}): _DeliveryMedium = DeliveryMedium, _AttributeName = AttributeName;
  
  factory MFAOption({String? DeliveryMedium, String? AttributeName}) {
    return MFAOption._internal(
      DeliveryMedium: DeliveryMedium,
      AttributeName: AttributeName);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MFAOption &&
      _DeliveryMedium == other._DeliveryMedium &&
      _AttributeName == other._AttributeName;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("MFAOption {");
    buffer.write("DeliveryMedium=" + "$_DeliveryMedium" + ", ");
    buffer.write("AttributeName=" + "$_AttributeName");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  MFAOption copyWith({String? DeliveryMedium, String? AttributeName}) {
    return MFAOption._internal(
      DeliveryMedium: DeliveryMedium ?? this.DeliveryMedium,
      AttributeName: AttributeName ?? this.AttributeName);
  }
  
  MFAOption.fromJson(Map<String, dynamic> json)  
    : _DeliveryMedium = json['DeliveryMedium'],
      _AttributeName = json['AttributeName'];
  
  Map<String, dynamic> toJson() => {
    'DeliveryMedium': _DeliveryMedium, 'AttributeName': _AttributeName
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "MFAOption";
    modelSchemaDefinition.pluralName = "MFAOptions";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'DeliveryMedium',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'AttributeName',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
  });
}