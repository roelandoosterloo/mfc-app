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


/** This is an auto generated class representing the Recipe type in your schema. */
@immutable
class Recipe extends Model {
  static const classType = const _RecipeModelType();
  final String id;
  final TemporalDate? _date;
  final ContentState? _state;
  final String? _name;
  final int? _totalMinutes;
  final int? _preparationMinutes;
  final String? _imageUrl;
  final String? _instructionVideoUrl;
  final List<RecipeStep>? _steps;
  final List<Ingredient>? _ingredients;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  TemporalDate get date {
    try {
      return _date!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  ContentState get state {
    try {
      return _state!;
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
  
  int get totalMinutes {
    try {
      return _totalMinutes!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  int get preparationMinutes {
    try {
      return _preparationMinutes!;
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
  
  String? get instructionVideoUrl {
    return _instructionVideoUrl;
  }
  
  List<RecipeStep>? get steps {
    return _steps;
  }
  
  List<Ingredient>? get ingredients {
    return _ingredients;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const Recipe._internal({required this.id, required date, required state, required name, required totalMinutes, required preparationMinutes, required imageUrl, instructionVideoUrl, steps, ingredients, createdAt, updatedAt}): _date = date, _state = state, _name = name, _totalMinutes = totalMinutes, _preparationMinutes = preparationMinutes, _imageUrl = imageUrl, _instructionVideoUrl = instructionVideoUrl, _steps = steps, _ingredients = ingredients, _createdAt = createdAt, _updatedAt = updatedAt;
  
  factory Recipe({String? id, required TemporalDate date, required ContentState state, required String name, required int totalMinutes, required int preparationMinutes, required String imageUrl, String? instructionVideoUrl, List<RecipeStep>? steps, List<Ingredient>? ingredients}) {
    return Recipe._internal(
      id: id == null ? UUID.getUUID() : id,
      date: date,
      state: state,
      name: name,
      totalMinutes: totalMinutes,
      preparationMinutes: preparationMinutes,
      imageUrl: imageUrl,
      instructionVideoUrl: instructionVideoUrl,
      steps: steps != null ? List<RecipeStep>.unmodifiable(steps) : steps,
      ingredients: ingredients != null ? List<Ingredient>.unmodifiable(ingredients) : ingredients);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Recipe &&
      id == other.id &&
      _date == other._date &&
      _state == other._state &&
      _name == other._name &&
      _totalMinutes == other._totalMinutes &&
      _preparationMinutes == other._preparationMinutes &&
      _imageUrl == other._imageUrl &&
      _instructionVideoUrl == other._instructionVideoUrl &&
      DeepCollectionEquality().equals(_steps, other._steps) &&
      DeepCollectionEquality().equals(_ingredients, other._ingredients);
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Recipe {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("date=" + (_date != null ? _date!.format() : "null") + ", ");
    buffer.write("state=" + (_state != null ? enumToString(_state)! : "null") + ", ");
    buffer.write("name=" + "$_name" + ", ");
    buffer.write("totalMinutes=" + (_totalMinutes != null ? _totalMinutes!.toString() : "null") + ", ");
    buffer.write("preparationMinutes=" + (_preparationMinutes != null ? _preparationMinutes!.toString() : "null") + ", ");
    buffer.write("imageUrl=" + "$_imageUrl" + ", ");
    buffer.write("instructionVideoUrl=" + "$_instructionVideoUrl" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Recipe copyWith({String? id, TemporalDate? date, ContentState? state, String? name, int? totalMinutes, int? preparationMinutes, String? imageUrl, String? instructionVideoUrl, List<RecipeStep>? steps, List<Ingredient>? ingredients}) {
    return Recipe._internal(
      id: id ?? this.id,
      date: date ?? this.date,
      state: state ?? this.state,
      name: name ?? this.name,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      preparationMinutes: preparationMinutes ?? this.preparationMinutes,
      imageUrl: imageUrl ?? this.imageUrl,
      instructionVideoUrl: instructionVideoUrl ?? this.instructionVideoUrl,
      steps: steps ?? this.steps,
      ingredients: ingredients ?? this.ingredients);
  }
  
  Recipe.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _date = json['date'] != null ? TemporalDate.fromString(json['date']) : null,
      _state = enumFromString<ContentState>(json['state'], ContentState.values),
      _name = json['name'],
      _totalMinutes = (json['totalMinutes'] as num?)?.toInt(),
      _preparationMinutes = (json['preparationMinutes'] as num?)?.toInt(),
      _imageUrl = json['imageUrl'],
      _instructionVideoUrl = json['instructionVideoUrl'],
      _steps = json['steps'] is List
        ? (json['steps'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => RecipeStep.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _ingredients = json['ingredients'] is List
        ? (json['ingredients'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Ingredient.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'date': _date?.format(), 'state': enumToString(_state), 'name': _name, 'totalMinutes': _totalMinutes, 'preparationMinutes': _preparationMinutes, 'imageUrl': _imageUrl, 'instructionVideoUrl': _instructionVideoUrl, 'steps': _steps?.map((RecipeStep? e) => e?.toJson()).toList(), 'ingredients': _ingredients?.map((Ingredient? e) => e?.toJson()).toList(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "id");
  static final QueryField DATE = QueryField(fieldName: "date");
  static final QueryField STATE = QueryField(fieldName: "state");
  static final QueryField NAME = QueryField(fieldName: "name");
  static final QueryField TOTALMINUTES = QueryField(fieldName: "totalMinutes");
  static final QueryField PREPARATIONMINUTES = QueryField(fieldName: "preparationMinutes");
  static final QueryField IMAGEURL = QueryField(fieldName: "imageUrl");
  static final QueryField INSTRUCTIONVIDEOURL = QueryField(fieldName: "instructionVideoUrl");
  static final QueryField STEPS = QueryField(
    fieldName: "steps",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (RecipeStep).toString()));
  static final QueryField INGREDIENTS = QueryField(
    fieldName: "ingredients",
    fieldType: ModelFieldType(ModelFieldTypeEnum.model, ofModelName: (Ingredient).toString()));
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Recipe";
    modelSchemaDefinition.pluralName = "Recipes";
    
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
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.DATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.date)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.STATE,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.enumeration)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.NAME,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.TOTALMINUTES,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.PREPARATIONMINUTES,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.int)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.IMAGEURL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: Recipe.INSTRUCTIONVIDEOURL,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Recipe.STEPS,
      isRequired: true,
      ofModelName: (RecipeStep).toString(),
      associatedKey: RecipeStep.RECIPEID
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.hasMany(
      key: Recipe.INGREDIENTS,
      isRequired: true,
      ofModelName: (Ingredient).toString(),
      associatedKey: Ingredient.RECIPE
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

class _RecipeModelType extends ModelType<Recipe> {
  const _RecipeModelType();
  
  @override
  Recipe fromJson(Map<String, dynamic> jsonData) {
    return Recipe.fromJson(jsonData);
  }
}