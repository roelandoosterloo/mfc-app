import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/recipe/list_recipe/list_recipe_bloc.dart';
import 'package:mfc_app/repositories/recipe_repository.dart';
import 'package:mfc_app/screens/recipe/list/recipe_list_screen.dart';

class RecipeListPage extends Page {
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
      settings: this,
      builder: (BuildContext context) => BlocProvider(
        create: (context) => ListRecipeBloc(
          recipeRepository: context.read<RecipeRepository>(),
        ),
        child: RecipeListScreen(),
      ),
    );
  }
}
