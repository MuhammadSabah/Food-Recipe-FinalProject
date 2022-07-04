import 'package:flutter/material.dart';
import 'package:food_recipe_final/components/recipe_card.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:food_recipe_final/models/api/recipe_api_model.dart';
import 'package:food_recipe_final/screens/recipe_detail_screen.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({
    Key? key,
    required this.context,
    required this.results,
  }) : super(key: key);
  final List<ResultsAPI> results;
  final BuildContext context;

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double itemWidth = (size.width / 2) - 10;
    double itemHeight = 292;
    return Expanded(
      child: GridView.builder(
        // controller: _scrollController,
        itemCount: widget.results.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (context, index) {
          print(widget.results[index]);
          final result = widget.results[index];
          return _buildRecipeCard(context, widget.results, index);
        },
      ),
    );
  }

  Widget _buildRecipeCard(
      BuildContext context, List<ResultsAPI> results, int index) {
    final recipe = results[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            final detailRecipe = RecipeModel(
              id: recipe.id,
              vegetarian: recipe.vegetarian,
              vegan: recipe.vegan,
              glutenFree: recipe.glutenFree,
              dairyFree: recipe.dairyFree,
              veryHealthy: recipe.veryHealthy,
              cheap: recipe.cheap,
              healthScore: recipe.healthScore,
              veryPopular: recipe.veryPopular,
              ingredients: convertIngredients(recipe.ingredients!),
              title: recipe.title,
              readyInMinutes: recipe.readyInMinutes,
              servings: recipe.servings,
              sourceUrl: recipe.sourceUrl,
              image: recipe.image,
              summary: recipe.summary,
              diets: recipe.diets,
              dishTypes: recipe.dishTypes,
              occasions: recipe.occasions,
              spoonacularSourceUrl: recipe.spoonacularSourceUrl,
              instructions: convertInstructions(recipe.instructions!),
              nutrition: convertNutritions(recipe.nutrition!),
              aggregateLikes: recipe.aggregateLikes,
            );
            return RecipeDetailScreen(
              recipe: detailRecipe,
            );
          },
        ));
      },
      child: RecipeCard(recipe: recipe),
    );
  }
}