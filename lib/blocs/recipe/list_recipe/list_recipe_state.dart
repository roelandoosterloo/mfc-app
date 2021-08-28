part of 'list_recipe_bloc.dart';

abstract class ListRecipeState extends Equatable {
  const ListRecipeState();

  @override
  List<Object> get props => [];
}

class ListRecipeInitial extends ListRecipeState {}

class RecipesLoading extends ListRecipeState {}

class RecipesAvailable extends ListRecipeState {
  final List<Recipe> _recipes;

  RecipesAvailable({required List<Recipe> recipes}) : _recipes = recipes;

  List<Recipe> get recipes => _recipes;

  @override
  List<Object> get props => [_recipes];
}

class RecipesListFailed extends ListRecipeState {
  final String _error;

  RecipesListFailed({String error = ""}) : _error = error;

  String? get error => _error;

  @override
  List<Object> get props => [_error];
}
