import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Model.dart';
import 'package:mfc_app/models/recipe/Recipe.dart';

import 'Product.dart';
import 'Unit.dart';

class Ingredient extends Model {
  final String id;
  final String _recipeId;
  final String _productId;
  final double _amount;
  final Unit _unit;
  final Recipe _recipe;
  final Product _product;

  @override
  String getId() {
    return id;
  }

  String get recipeId {
    return _recipeId;
  }

  String get productId {
    return _productId;
  }

  double get amount {
    return _amount;
  }

  Unit get unit {
    return _unit;
  }

  Recipe get recipe {
    return _recipe;
  }

  Product get product {
    return _product;
  }

  const Ingredient._interal({
    required this.id,
    required recipeId,
    required productId,
    required amount,
    required unit,
    required recipe,
    required product,
  })  : _recipeId = recipeId,
        _productId = productId,
        _amount = amount,
        _unit = unit,
        _recipe = recipe,
        _product = product;

  factory Ingredient(
      {String? id,
      required String recipeId,
      required String productId,
      required double amount,
      required Unit unit,
      required Recipe recipe,
      required Product product}) {
    return Ingredient._interal(
        id: id == null ? UUID.getUUID() : id,
        recipeId: recipeId,
        productId: productId,
        amount: amount,
        unit: unit,
        recipe: recipe,
        product: product);
  }

  Ingredient.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _recipeId = json['recipeId'],
        _productId = json['productId'],
        _amount = json['amount'],
        _unit = Unit.fromJson(json['unit']),
        _recipe = Recipe.fromJson(json['recipe']),
        _product = Product.fromJson(json['product']);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'recipeId': _recipeId,
        'productId': _productId,
        'amount': _amount,
        'unit': _unit.toJson(),
        'recipe': _recipe.toJson(),
        'product': _product.toJson(),
      };
}
