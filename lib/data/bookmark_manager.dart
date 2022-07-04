import 'package:flutter/material.dart';
import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:food_recipe_final/data/bookmark.dart';

class BookmarkManager extends Bookmark with ChangeNotifier {
  final List<RecipeModel> _currentRecipes = [];
  final List<IngredientModel> _currentIngredients = [];

  @override
  List<RecipeModel> findAllRecipes() {
    return _currentRecipes;
  }

  @override
  RecipeModel findRecipeById(int id) {
    return _currentRecipes.firstWhere((recipe) => recipe.id == id);
  }

  @override
  List<IngredientModel> findAllIngredients() {
    return _currentIngredients;
  }

  @override
  void insertRecipe(RecipeModel recipe) {
    _currentRecipes.add(recipe);
    if (recipe.ingredients != null) {
      insertIngredients(recipe.ingredients!);
    }
    notifyListeners();
  }

  @override
  List<int> insertIngredients(List<IngredientModel> ingredients) {
    if (ingredients.length != 0) {
      _currentIngredients.addAll(ingredients);
    }
    notifyListeners();
    return <int>[];
  }

  @override
  void deleteRecipe(RecipeModel recipe) {
    _currentRecipes.remove(recipe);
  }

  @override
  void deleteIngredient(IngredientModel ingredient) {
    _currentIngredients.remove(ingredient);
  }

  @override
  void deleteIngredients(List<IngredientModel> ingredients) {
    _currentIngredients.removeWhere(
      (ingredient) => ingredients.contains(ingredient),
    );
    notifyListeners();
  }

  @override
  Future init() {
    return Future.value(null);
  }

  @override
  void close() {}
}