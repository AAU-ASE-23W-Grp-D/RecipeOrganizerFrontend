import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/api.dart';
import 'package:recipe_organizer_frontend/utils/meal_plan_storage.dart';

Map<String, List<String>> recipeMap = {};
SecureStorageMealPlanning _preferences = SecureStorageMealPlanning();

List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class MealPlanningScreen extends StatefulWidget {
  const MealPlanningScreen({super.key});

  @override
  MealPlanningScreenState createState() => MealPlanningScreenState();
}

class MealPlanningScreenState extends State<MealPlanningScreen> {

//updates the meal plan from the secure storage and gets all recipes for the alert dropdown
  @override
  void initState() {
    super.initState();
    _updateMealPlan();
    _loadRecipes();
  }

//updates the meal plan
  void _updateMealPlan() async {
    Map<String, List<String>> recipeMapNew =
        await _preferences.getMealPlanning();
    setState(() {
      recipeMap = recipeMapNew;
    });
  }

  // Method to delete all items from a card
  void deleteAllRecipes(String day) async {
    await _preferences.deleteAllRecipes(day);
    _updateMealPlan();
  }

//deletes a recipe from a specific day
  void deleteRecipes(String day, String recipe) async {
    await _preferences.deleteRecipe(day, recipe);
    _updateMealPlan();
  }

//gets the names from all the recipes from the local database
  Future<List<String>> fetchRecipeNames() async {
    List<Recipe> recipes = await Api().fetchRecipes();
    List<String> recipeNames = recipes.map((recipe) => recipe.name).toList();
    return recipeNames;
  }

  List<String> allRecipes = [];

  String? selectedRecipe;

//loads the recipes in the alert dialog
  Future<void> _loadRecipes() async {
    List<String> recipeNames = await fetchRecipeNames();
    setState(() {
      allRecipes = recipeNames;
    });
  }

//alert dialog that shows all recipes name to add to a specific day in the meal plan
  void _showAddRecipeDialog(String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: const Key("AddMealDialog"),
          title: Text('Add Recipe to $day'),
          content: SizedBox(
            height: 150,
            child: Column(
              children: [
                const Text('Select a recipe:'),
                DropdownButton<String>(
                  key: const Key("RecipeDropDown"),
                  value: selectedRecipe,
                  items: allRecipes.map((String recipe) {
                    return DropdownMenuItem<String>(
                      value: recipe,
                      child: Text(recipe),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRecipe = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              key: const Key("AddButtonDialog"),
              onPressed: () {
                // Add your logic to add the selected recipe to the day
                if (selectedRecipe != null) {
                  // Assuming you have a method to add a recipe to the day
                  addRecipe(day: day, recipe: selectedRecipe!);
                }
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
            ElevatedButton(
              key: const Key("CancelButtonDialog"),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Method to add a recipe to a day
  void addRecipe({required String day, required String recipe}) async {
    await _preferences.insertRecipe(day, recipe);
    Map<String, List<String>> recipeMapNew =
        await _preferences.getMealPlanning();
    setState(() {
      recipeMap = recipeMapNew;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: const Key("mealplanappbar"),
        title: const Text('Meal Planning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display recipes for each weekday
            for (String day in days)
              _buildDayCard(
                  day: day, recipes: recipeMap[day] ?? [], context: context),
          ],
        ),
      ),
    );
  }

//Card for each day of the week for the recipes to add with buttons to add, delete and delete all recipes per day
  Widget _buildDayCard(
      {required String day, required List<String> recipes, required context}) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: 16.0),
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
        child: ExpansionTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  if (screenWidth >= 700)
                    Row(
                      children: [
                        ElevatedButton(
                          key: const Key("AddButtonRecipeCard"),
                          onPressed: () {
                            _showAddRecipeDialog(day);
                          },
                          child: const Text("Add"),
                        ),
                        const SizedBox(width: 8.0),
                        ElevatedButton(
                          key: const Key("DeleteAllButtonRecipeCard"),
                          onPressed: () {
                            deleteAllRecipes(day);
                          },
                          child: const Text("Delete All"),
                        ),
                      ],
                    ),
                  if (screenWidth < 700)
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _showAddRecipeDialog(day);
                          },
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            deleteAllRecipes(day);
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                ],
              ),
              const SizedBox(height: 8),
            ],
          ),
          children: [
            // Display the list of recipes for the day
            for (String recipe in recipes)
              ListTile(
                title: Text(
                  recipe,
                  style: const TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  key: const Key("DeleteIconButtonList"),
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteRecipes(day, recipe);
                  },
                ),
                onTap: () {
                  // Navigate to the screen where users can view the details of the selected recipe
                  /*
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RecipeDetailScreenWeb(recipe: ,),
                    ),
                  );
                  */
                },
              ),
          ],
        ),
      ),
    );
  }
}
