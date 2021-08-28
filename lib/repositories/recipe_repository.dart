import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:mfc_app/models/ContentState.dart';
import 'package:mfc_app/models/recipe/Recipe.dart';

class RecipeRepository {
  Future<List<Recipe>> listRecipes() async {
    String graphQLDocument = '''
    query ListRecipes(state: "${ContentState.LIVE.name}") {
      listRecipes {
        items {
          id
          date
          name
          totalMinutes
          preparationMinutes
          imageUrl
        }
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    GraphQLResponse response = await op.response;
    Map<String, dynamic> json = jsonDecode(response.data);
    List<dynamic> items = json['listRecipes']['items'];
    return items.map((it) => Recipe.fromJson(it)).toList();
  }

  Future<Recipe> getRecipe(String recipeId) async {
    String graphQLDocument = '''
    query GetRecipe {
      getRecipe {
        id
        date
        totalMinutes
        preparationMinutes
        imageUrl
        instructionVideoUrl
        steps: {
          items: {
            index
            instructionText
          }
        }
        ingredients: {
          items: {
            amount
            unit
            product: {
              name
              namePlural
            }
          }
        }
      }
    }
    ''';
    GraphQLOperation op = Amplify.API.query(
      request: GraphQLRequest(
        document: graphQLDocument,
      ),
    );
    GraphQLResponse response = await op.response;
    Map<String, dynamic> json = jsonDecode(response.data);
    Recipe recipe = Recipe.fromJson(json);
    return recipe;
  }
}
