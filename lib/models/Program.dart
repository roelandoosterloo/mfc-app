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


/** This is an auto generated class representing the Program type in your schema. */
@immutable
class Program extends Model {
  static const classType = const _ProgramModelType();
  final String id;
  final String? _name;
  final bool? _isForSale;
  final double? _price;
  final String? _description;
  final String? _imageUrl;
  final String? _productUrl;
  final String? _productStoreId;
  final List<ProgramCourse>? _courses;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
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
  
  bool get isForSale {
    try {
      return _isForSale!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  double? get price {
    return _price;
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
  
  String get imageUrl {
    try {
      return _imageUrl!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String get productUrl {
    try {
      return _productUrl!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get productStoreId {
    return _productStoreId;
  }
  
  List<ProgramCourse> get courses {
    try {
      return _courses!;
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
  
  const Program._internal({required this.id, required name, required isForSale, price, required description, required imageUrl, required productUrl, productStoreId, required courses, createdAt, updatedAt}): _name = name, _isForSale = isForSale, _price = price, _description = description, _imageUrl = imageUrl, _productUrl = productUrl, _productStoreId = productStoreId, _courses = courses, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Program({String? id, required String name, required bool isForSale, double? price, required String description, required String imageUrl, required String productUrl, String? productStoreId, required List<ProgramCourse> courses}) {
    return Program._internal(
      id: id == null ? UUID.getUUID() : id,
      name: name,
      isForSale: isForSale,
      price: price,
      description: description,
      imageUrl: imageUrl,
      productUrl: productUrl,
      productStoreId: productStoreId,
      courses: courses != null ? List<ProgramCourse>.unmodifiable(courses) : courses);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Program &&
      id == other.id &&
      _name == other._name &&
      _isForSale == other._isForSale &&
      _price == other._price &&
      _description == other._description &&
      _imageUrl == other._imageUrl &&
      _productUrl == other._productUrl &&
      _productStoreId == other._productStoreId &&
      DeepCollectionEquality().equals(_courses, other._courses);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Program {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("isForSale=" + (_isForSale != null ? _isForSale!.toString() : "null") + ", ");
    buffer.write("price=" + (_price != null ? _price!.toString() : "null") + ", ");
    buffer.write("description=" + "$_description" + ", ");
    buffer.write("imageUrl=" + "$_imageUrl" + ", ");
    buffer.write("productUrl=" + "$_productUrl" + ", ");
    buffer.write("productStoreId=" + "$_productStoreId" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Program copyWith({String? id, String? name, bool? isForSale, double? price, String? description, String? imageUrl, String? productUrl, String? productStoreId, List<ProgramCourse>? courses}) {
    return Program._internal(
      id: id ?? this.id,
      name: name ?? this.name,
      isForSale: isForSale ?? this.isForSale,
      price: price ?? this.price,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      productUrl: productUrl ?? this.productUrl,
      productStoreId: productStoreId ?? this.productStoreId,
      courses: courses ?? this.courses);
  }
  
  Program.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _name = json['name'],
      _isForSale = json['isForSale'],
      _price = (json['price'] as num?)?.toDouble(),
      _description = json['description'],
      _imageUrl = json['imageUrl'],
      _productUrl = json['productUrl'],
      _productStoreId = json['productStoreId'],
      _courses = json['courses'] is List
        ? (json['courses'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => ProgramCourse.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'name': _name, 'isForSale': _isForSale, 'price': _price, 'description': _description, 'imageUrl': _imageUrl, 'productUrl': _productUrl, 'productStoreId': _productStoreId, 'courses': _courses?.map((ProgramCourse? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField ISFORSALE = QueryField(fieldName: "isForSale");
  static final QueryField PRICE = QueryField(fieldName: "price");
  static final QueryField DESCRIPTION = QueryField(fieldName: "description");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageUrl");
  static final QueryField PRODUCTURL = QueryField(fieldName: "productUrl");
  static final QueryField PRODUCTSTOREID = QueryField(fieldName: "productStoreId");
  static final QueryField COURSES = QueryField(
    fieldName: "courses",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (ProgramCourse).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Program";
    modelSchemaDefinition.pluralName = "Programs";
    
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
        ]),
      AuthRule(
        authStrategy: AuthStrategy.PRIVATE,
        provider: AuthRuleProvider.IAM,
        operations: [
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.ISFORSALE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.bool)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.PRICE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.double)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.DESCRIPTION,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.IMAGEURL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.PRODUCTURL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Program.PRODUCTSTOREID,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Program.COURSES,
      isRequired: false,
      ofModelName: (ProgramCourse).toString(),
      associatedKey: ProgramCourse.PROGRAM
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

class _ProgramModelType extends ModelType<Program> {
  const _ProgramModelType();
  
  @override
  Program fromJson(Map<String, dynamic> jsonData) {
    return Program.fromJson(jsonData);
  }
}