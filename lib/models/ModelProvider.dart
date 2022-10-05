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
import 'Answer.dart';
import 'Course.dart';
import 'Downloadable.dart';
import 'Enrollment.dart';
import 'Ingredient.dart';
import 'Measurement.dart';
import 'Membership.dart';
import 'Module.dart';
import 'ModuleProgress.dart';
import 'Option.dart';
import 'Product.dart';
import 'Profile.dart';
import 'Program.dart';
import 'ProgramCourse.dart';
import 'Question.dart';
import 'Recipe.dart';
import 'RecipeStep.dart';
import 'Unit.dart';
import 'CognitoGroup.dart';
import 'MFAOption.dart';

export 'Answer.dart';
export 'CognitoGroup.dart';
export 'ContentState.dart';
export 'Course.dart';
export 'Downloadable.dart';
export 'Enrollment.dart';
export 'Ingredient.dart';
export 'MFAOption.dart';
export 'Measurement.dart';
export 'Membership.dart';
export 'Module.dart';
export 'ModuleProgress.dart';
export 'Option.dart';
export 'Product.dart';
export 'Profile.dart';
export 'Program.dart';
export 'ProgramCourse.dart';
export 'Question.dart';
export 'QuestionType.dart';
export 'Recipe.dart';
export 'RecipeStep.dart';
export 'Unit.dart';
export 'UserStatus.dart';

class ModelProvider implements ModelProviderInterface {
  @override
  String version = "21dcdd66fc875d3cdb579eb3f6efefb9";
  @override
  List<ModelSchema> modelSchemas = [
    Answer.schema,
    Course.schema,
    Downloadable.schema,
    Enrollment.schema,
    Ingredient.schema,
    Measurement.schema,
    Membership.schema,
    Module.schema,
    ModuleProgress.schema,
    Option.schema,
    Product.schema,
    Profile.schema,
    Program.schema,
    ProgramCourse.schema,
    Question.schema,
    Recipe.schema,
    RecipeStep.schema,
    Unit.schema
  ];
  static final ModelProvider _instance = ModelProvider();
  @override
  List<ModelSchema> customTypeSchemas = [CognitoGroup.schema, MFAOption.schema];

  static ModelProvider get instance => _instance;

  ModelType getModelTypeByModelName(String modelName) {
    switch (modelName) {
      case "Answer":
        return Answer.classType;
      case "Course":
        return Course.classType;
      case "Downloadable":
        return Downloadable.classType;
      case "Enrollment":
        return Enrollment.classType;
      case "Ingredient":
        return Ingredient.classType;
      case "Measurement":
        return Measurement.classType;
      case "Membership":
        return Membership.classType;
      case "Module":
        return Module.classType;
      case "ModuleProgress":
        return ModuleProgress.classType;
      case "Option":
        return Option.classType;
      case "Product":
        return Product.classType;
      case "Profile":
        return Profile.classType;
      case "Program":
        return Program.classType;
      case "ProgramCourse":
        return ProgramCourse.classType;
      case "Question":
        return Question.classType;
      case "Recipe":
        return Recipe.classType;
      case "RecipeStep":
        return RecipeStep.classType;
      case "Unit":
        return Unit.classType;
      default:
        throw Exception(
            "Failed to find model in model provider for model name: " +
                modelName);
    }
  }
}
