import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:recipe_organizer_frontend/utils/meal_plan_storage.dart';
import 'package:recipe_organizer_frontend/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  _MealPlanningScreenState createState() => _MealPlanningScreenState();
}

class _MealPlanningScreenState extends State<MealPlanningScreen> {
  // Add your existing methods here
    // Method to delete one item from a card

    @override
  void initState() {
    super.initState();
    //_insertExample();
    _updateMealPlan();
  }

  void _updateMealPlan() async {
    Map<String, List<String>> recipeMapNew = await _preferences.getMealPlanning();
    
    setState(() {
      recipeMap = recipeMapNew;
    });
  }

  // Method to delete all items from a card
  void deleteAllRecipes(String day) async {
    await _preferences.deleteAllRecipes(day);
    _updateMealPlan();
  }

  void deleteRecipes(String day, String recipe) async {
    await _preferences.deleteRecipe(day,recipe);
    _updateMealPlan();
  }

    List<String> allRecipes = ['Cheeseburger', 'Pizza', 'Fried Chicken', 'Schnitzel', 'Sushi'];

  String? selectedRecipe;

  void _showAddRecipeDialog(String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          key: Key("AddMealDialog"),
          title: Text('Add Recipe to $day'),
          content: Column(
            children: [
              Text('Select a recipe:'),
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
              child: Text('OK'),
            ),
            ElevatedButton(
              key: const Key("CancelButtonDialog"),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Method to add a recipe to a day
  void addRecipe({required String day, required String recipe}) async {
    await _preferences.insertRecipe(day,recipe);
     Map<String, List<String>> recipeMapNew = await _preferences.getMealPlanning();

    
    setState((){
      // Assuming you have a Map<String, List<String>> to store recipes for each day
      recipeMap = recipeMapNew;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: Key("mealplanappbar"),
        title: Text('Meal Planning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display recipes for each weekday
            for (String day in days)
              _buildDayCard(day: day, recipes: recipeMap?[day] ?? [], context: context),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard({required String day, required List<String> recipes, required context}) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0),
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  if (screenWidth >= 700)
                    Row(
                      children: [
                        ElevatedButton(
                          key: const Key("AddButtonRecipeCard"),
                          onPressed: () {
                            _showAddRecipeDialog(day);
                          },
                          child: Text("Add"),
                        ),
                        SizedBox(width: 8.0),
                        ElevatedButton(
                          key: const Key("DeleteAllButtonRecipeCard"),
                          onPressed: () {
                            deleteAllRecipes(day);
                          },
                          child: Text("Delete All"),
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
                          icon: Icon(Icons.add),
                        ),
                        SizedBox(width: 8.0),
                        IconButton(
                          onPressed: () {
                            deleteAllRecipes(day);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 8),
            ],
          ),
          children: [
            // Display the list of recipes for the day
            for (String recipe in recipes)
              ListTile(
                title: Text(
                  recipe,
                  style: TextStyle(color: Colors.white),
                ),
                trailing: IconButton(
                  key: Key("DeleteIconButtonList"),
                  icon: Icon(Icons.delete),
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
