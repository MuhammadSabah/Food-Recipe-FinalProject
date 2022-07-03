import 'package:food_recipe_final/data/class_models/ingredient_model.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';

abstract class Bookmark {
  List<RecipeModel> findAllRecipes();
  RecipeModel findRecipeById(int id);
  List<IngredientModel> findAllIngredients();

  void insertRecipe(RecipeModel recipe);
  List<int> insertIngredients(List<IngredientModel> ingredients);

  void deleteRecipe(RecipeModel recipe);
  void deleteIngredient(IngredientModel ingredient);
  void deleteIngredients(List<IngredientModel> ingredients);

  // Future init();
  // void close();
}
