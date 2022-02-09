import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/ContentState.dart';
import 'package:mfc_app/models/recipe/Ingredient.dart';
import 'package:mfc_app/models/recipe/RecipeStep.dart';

import '../Model.dart';

class Recipe extends Model {
  final String id;
  final DateTime _date;
  final ContentState _state;
  final String _name;
  final int _totalMinutes;
  final int _preparationMinutes;
  final String _imageUrl;
  final String? _instructionVideoUrl;
  final List<RecipeStep>? _steps;
  final List<Ingredient>? _ingredients;

  @override
  String getId() {
    return id;
  }

  DateTime get date {
    return _date;
  }

  ContentState get state {
    return _state;
  }

  String get name {
    return _name;
  }

  int get totalMinutes {
    return _totalMinutes;
  }

  int get preparationMinutes {
    return _preparationMinutes;
  }

  String get imageUrl {
    return _imageUrl;
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

  const Recipe._internal({
    required this.id,
    required date,
    required state,
    required name,
    required totalMinutes,
    required preparationMinutes,
    required imageUrl,
    instructionVideoUrl,
    steps,
    ingredients,
  })  : _date = date,
        _state = state,
        _name = name,
        _totalMinutes = totalMinutes,
        _preparationMinutes = preparationMinutes,
        _imageUrl = imageUrl,
        _instructionVideoUrl = instructionVideoUrl,
        _steps = steps,
        _ingredients = ingredients;

  factory Recipe(
      {String? id,
      required DateTime date,
      ContentState? state,
      required String name,
      required int totalMinutes,
      required int preparationMinutes,
      required String imageUrl,
      String? instructionVideoUrl,
      List<RecipeStep>? steps,
      List<Ingredient>? ingredients}) {
    return Recipe._internal(
        id: id == null ? UUID.getUUID() : id,
        date: date,
        state: state ?? ContentState.DRAFT,
        name: name,
        totalMinutes: totalMinutes,
        preparationMinutes: preparationMinutes,
        imageUrl: imageUrl,
        steps: steps,
        ingredients: ingredients);
  }

  Recipe.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _date = json['date'],
        _state = ContentStateExtension.byString(json['state']),
        _name = json['name'],
        _totalMinutes = json['totalMinutes'],
        _preparationMinutes = json['preparationMinutes'],
        _imageUrl = json['imageUrl'],
        _instructionVideoUrl = json['instructionVideoUrl'],
        _steps = json['steps']?['items'] is List
            ? (json['steps']['items'] as List)
                .map((e) =>
                    RecipeStep.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null,
        _ingredients = json['ingredients']?['items'] is List
            ? (json['ingredients']['items'] as List)
                .map((e) =>
                    Ingredient.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : null;

  @override
  Map<String, dynamic> toJson() => {
        'date': _date,
        'state': _state.name,
        'name': _name,
        'totalMinutes': _totalMinutes,
        'preparationMinutes': _preparationMinutes,
        'imageUrl': _imageUrl,
        'steps': _steps?.map((e) => e.toJson()).toList(),
        'ingredients': _ingredients?.map((e) => e.toJson()).toList()
      };
}
