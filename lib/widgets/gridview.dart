// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:recipe_organizer_frontend/utils/api.dart';
import 'package:recipe_organizer_frontend/utils/favorited_recipes_storage.dart';
import 'package:recipe_organizer_frontend/utils/meal_plan_storage.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';

SecureStorageMealPlanning _prefMP = SecureStorageMealPlanning();
FavoritedRecipesStorage _favoritedRecipesStorage = FavoritedRecipesStorage();

// Widget for displaying a grid of recipes
class GridB extends StatefulWidget {
  final Future<List<Recipe>> Function() fetchFunction;
  final bool ableToDelete;

  const GridB(
      {super.key, required this.fetchFunction, this.ableToDelete = false});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  late Future<List<Recipe>> futureRecipes;
  int totalCreatedRecipes = 0; // Track the total number of recipes of user
  Set<int> favoriteRecipes = <int>{};
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    futureRecipes = widget.fetchFunction();
    _loadFavoriteRecipes();
  }

  Future<void> _loadFavoriteRecipes() async {
    favoriteRecipes =
        (await _favoritedRecipesStorage.getFavoritedRecipesId()).toSet();
  }

  Future<void> _updateFavoriteRecipe(Recipe recipe, bool isFavorite) async {
    if (isFavorite) {
      await _favoritedRecipesStorage.addRecipe(recipe);
      print("Recipe added to favorites");
    } else {
      await _favoritedRecipesStorage.removeRecipe(recipe);
      print("Recipe removed from favorites");
    }
  }

  // Calculate the number of cross-axis items based on screen width
  int calculateCrossAxisCount(double screenWidth) {
    int baseCount = 7; // Adjust this based on your initial design
    int calculatedCount =
        (screenWidth / 200).round(); // Adjust 200 based on your item width

    return calculatedCount > baseCount ? calculatedCount : baseCount;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: futureRecipes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // or another loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Recipe> recipes = snapshot.data as List<Recipe>;

          if (widget.fetchFunction == Api().fetchUserRecipes) {
            // If the profile page is loaded, calculate total created recipes
            totalCreatedRecipes = recipes.length;
            UserStorage().saveTotalCreatedRecipes(totalCreatedRecipes);
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount =
                  (MediaQuery.of(context).size.width ~/ 209).toInt();
              return GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: kIsWeb ? crossAxisCount : 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 270,
                ),
                itemCount: recipes.length,
                itemBuilder: (_, index) {
                  Recipe recipe = recipes[index];

                  return Container(
                    constraints: const BoxConstraints(maxWidth: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          secondary,
                          primary,
                        ],
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(16.0),
                            topRight: Radius.circular(16.0),
                          ),
                          child: Image.memory(
                            recipe.image,
                            height: 170,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .merge(
                                      const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                              const SizedBox(
                                height: 8.0,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${recipe.rating} ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .merge(
                                          TextStyle(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                  ),
                                  const Icon(Icons.star, color: Colors.grey),
                                  Visibility(
                                    visible: !widget.ableToDelete,
                                    child: IconButton(
                                      onPressed: () async {
                                        if (favoriteRecipes
                                            .contains(recipe.ID)) {
                                          favoriteRecipes.remove(recipe.ID);
                                          await _updateFavoriteRecipe(
                                              recipe, false);
                                        } else {
                                          favoriteRecipes.add(recipe.ID);
                                          await _updateFavoriteRecipe(
                                              recipe, true);
                                        }
                                        setState(() {});
                                      },
                                      color: favoriteRecipes.contains(recipe.ID)
                                          ? Colors.red
                                          : Colors.grey,
                                      icon:
                                          const Icon(CupertinoIcons.heart_fill),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RecipeDetailScreenWeb(
                                            recipe: recipe,
                                          ),
                                        ),
                                      );
                                    },
                                    color: Colors.white,
                                    icon: const Icon(
                                      CupertinoIcons.search,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _showDialog(context, recipe.name);
                                    },
                                    color: Colors.black,
                                    icon: const Icon(
                                      CupertinoIcons.add,
                                    ),
                                  ),
                                  Visibility(
                                    visible: widget.ableToDelete,
                                    child: IconButton(
                                      key: Key('delete_${recipe.name}'),
                                      onPressed: () async {
                                        await Api().deleteRecipe(recipe.ID);
                                        setState(() {
                                          futureRecipes =
                                              widget.fetchFunction();
                                        });
                                      },
                                      color: Colors.redAccent,
                                      icon: const Icon(
                                        CupertinoIcons.delete,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        }
      },
    );
  }

  // Function to show a dialog for assigning a recipe to a day
  Future<void> _showDialog(BuildContext context, String name) async {
    String selectedDay = 'Monday'; // Initial value

    void insertMealPlan(String day, String recipe) async {
      await _prefMP.insertRecipe(day, recipe);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Day'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                Text("I plan to eat $name on:"),
                DropdownButton<String>(
                  value: selectedDay,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedDay = newValue;
                    }
                  },
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // inserts into meal plan
                    insertMealPlan(selectedDay, name);
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('Assign'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
