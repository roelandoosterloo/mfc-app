import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:mfc_app/models/Model.dart';

class RecipeStep extends Model {
  final String id;
  final String _recipeId;
  final int _index;
  final String _instructionText;

  @override
  String getId() {
    return id;
  }

  String get recipeId {
    return _recipeId;
  }

  int get index {
    return _index;
  }

  String get instructionText {
    return _instructionText;
  }

  const RecipeStep._internal(
      {required this.id,
      required recipeId,
      required index,
      required instructionText})
      : _recipeId = recipeId,
        _index = index,
        _instructionText = instructionText;

  factory RecipeStep(
      {String? id,
      required String recipeId,
      required int index,
      required String instructionStep}) {
    return RecipeStep._internal(
      id: id == null ? UUID.getUUID() : id,
      recipeId: recipeId,
      index: index,
      instructionText: instructionStep,
    );
  }

  RecipeStep.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        _recipeId = json['recipeId'],
        _index = json['index'],
        _instructionText = json['instructionText'];

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'recipeId': _recipeId,
        'index': _index,
        'instructionText': _instructionText
      };
}
