import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/recipe/Ingredient.dart';

class Product extends Model {
  final String id;
  final String _name;
  final String _pluralName;
  final List<Ingredient> _ingredients;

  @override
  String getId() {
    return id;
  }

  String get name {
    return _name;
  }

  String get pluralName {
    return _pluralName;
  }

  List<Ingredient> get ingredients {
    return _ingredients;
  }

  const Product._interal({
    required this.id,
    required name,
    required pluralName,
    required ingredients,
  })  : _name = name,
        _pluralName = pluralName,
        _ingredients = ingredients;

  factory Product(
      {String? id,
      required String name,
      required String pluralName,
      required List<Ingredient> ingredients}) {
    return Product._interal(
        id: id == null ? UUID.getUUID() : id,
        name: name,
        pluralName: pluralName,
        ingredients: ingredients);
  }

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _name = json['name'],
        _pluralName = json['pluralName'],
        _ingredients = json['ingredients']?['items'] is List
            ? (json['ingredients']['items'] as List)
                .map((e) =>
                    Ingredient.fromJson(new Map<String, dynamic>.from(e)))
                .toList()
            : List.empty();

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': _name,
        'pluralName': _pluralName,
        'ingredients': ingredients.map((e) => e.toJson()).toList(),
      };
}
