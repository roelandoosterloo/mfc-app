import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/recipe/Recipe.dart';
import 'package:mfc_app/repositories/recipe_repository.dart';

part 'list_recipe_event.dart';
part 'list_recipe_state.dart';

class ListRecipeBloc extends Bloc<ListRecipeEvent, ListRecipeState> {
  final RecipeRepository _recipeRepo;

  ListRecipeBloc({required RecipeRepository recipeRepository})
      : _recipeRepo = recipeRepository,
        super(ListRecipeInitial());

  @override
  Stream<ListRecipeState> mapEventToState(ListRecipeEvent event) async* {
    if (event is RecipesRequested) {
      yield* _mapDataRequestedToState();
    } else if (event is RecipesFound) {
      yield* _mapFoundToState(event.recipes);
    } else if (event is RecipesLoadingFailed) {
      yield* _mapLoadingFailedToState(event.error);
    }
  }

  Stream<ListRecipeState> _mapDataRequestedToState() async* {
    yield RecipesLoading();
    List<Recipe> recipes = await _recipeRepo.listRecipes();
    add(RecipesFound(recipes));
  }

  Stream<ListRecipeState> _mapFoundToState(List<Recipe> recipe) async* {
    yield RecipesAvailable(recipes: recipe);
  }

  Stream<ListRecipeState> _mapLoadingFailedToState(String error) async* {
    yield RecipesListFailed(error: error);
  }
}
