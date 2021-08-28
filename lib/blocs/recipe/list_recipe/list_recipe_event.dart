part of 'list_recipe_bloc.dart';

abstract class ListRecipeEvent extends Equatable {
  const ListRecipeEvent();

  @override
  List<Object> get props => [];
}

class RecipesRequested extends ListRecipeEvent {}

class RecipesFound extends ListRecipeEvent {
  final List<Recipe> recipes;

  RecipesFound(this.recipes);
}

class RecipesLoadingFailed extends ListRecipeEvent {
  final String error;

  RecipesLoadingFailed(this.error);
}
