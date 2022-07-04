import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe_final/app_theme.dart';
import 'package:food_recipe_final/components/bottom_save_button.dart';
import 'package:food_recipe_final/data/bookmark_manager.dart';
import 'package:food_recipe_final/data/class_models/recipe_model.dart';
import 'package:provider/provider.dart';

class RecipeDetailScreen extends StatelessWidget {
  RecipeDetailScreen({Key? key, required this.recipe}) : super(key: key);

  final RecipeModel recipe;
  late List nutritionsList = [];
  @override
  Widget build(BuildContext context) {
    final bookmarkManager = Provider.of<BookmarkManager>(context);
    nutritionsList = recipe.nutrition!.nutrients!
        .where(
          (nutrition) =>
              nutrition.name == 'Calories' ||
              nutrition.name == 'Fat' ||
              nutrition.name == 'Carbohydrates' ||
              nutrition.name == 'Sugar' ||
              nutrition.name == 'Protein' ||
              nutrition.name == 'Fiber',
        )
        .toList();

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 3.4,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black,
                            ],
                            stops: [0, 0.2, 0.8, 1],
                          ),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: recipe.image!,
                          fit: BoxFit.cover,
                          fadeInCurve: Curves.easeInOut,
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Row(
                          children: [
                            IconButton(
                              splashRadius: 20,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          splashRadius: 20,
                          onPressed: () {
                            // Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 14,
                        bottom: 40,
                        child: Container(
                          height: 28,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // gradient: const LinearGradient(
                            //   begin: Alignment.topLeft,
                            //   end: Alignment.bottomCenter,
                            //   colors: [
                            //     Colors.white60,
                            //     Colors.white10,
                            //   ],
                            // ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.all(
                              width: 2,
                              color: Colors.white30,
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Icon(
                                Icons.thumb_up_alt_outlined,
                                size: 23,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Text(
                                  "${recipe.aggregateLikes}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Transform.translate(
                    offset: const Offset(0, -30),
                    child: Container(
                      // height: MediaQuery.of(context).size.height -
                      //     (MediaQuery.of(context).size.height / 3.4),
                      decoration: const BoxDecoration(
                        color: kBlackColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.star_outline,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              recipe.title!,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(
                                    fontSize: 28,
                                  ),
                            ),
                            const SizedBox(height: 26),
                            Divider(
                              color: Colors.grey.shade500,
                              thickness: 1.1,
                            ),
                            const SizedBox(height: 26),
                            Text(
                              "Ingredients",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 18),
                            ListView.separated(
                              // physics: const NeverScrollableScrollPhysics(),
                              separatorBuilder: (_, index) {
                                return const SizedBox(height: 8);
                              },
                              primary: false,
                              shrinkWrap: true,
                              itemCount: recipe.ingredients!.length,
                              itemBuilder: (context, index) {
                                return Text(
                                  '${recipe.ingredients![index].name}',
                                  style: Theme.of(context).textTheme.headline3,
                                );
                              },
                            ),
                            const SizedBox(height: 26),
                            Divider(
                              color: Colors.grey.shade500,
                              thickness: 1.1,
                            ),
                            const SizedBox(height: 26),
                            Text(
                              "Nutritions:",
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            const SizedBox(height: 18),
                            ListView.separated(
                              separatorBuilder: ((context, index) =>
                                  const SizedBox(height: 8)),
                              itemCount: nutritionsList.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Text("${nutritionsList[index].name}: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3),
                                    Text(
                                      "${nutritionsList[index].amount.toStringAsFixed(1)}${nutritionsList[index].unit}",
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                    ),
                                  ],
                                );
                              },
                              physics: const NeverScrollableScrollPhysics(),
                              primary: false,
                              shrinkWrap: true,
                            ),
                            const SizedBox(height: 19),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const BottomSaveButton(),
          ],
        ),
      ),
    );
  }
}
