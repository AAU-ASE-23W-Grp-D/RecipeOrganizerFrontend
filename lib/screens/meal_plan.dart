import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';

class MealPlanningScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Replace this list with actual recipe data
    List<String> recipes = [
      'Recipe 1',
      'Recipe 2',
      'Recipe 3',
      'Recipe 4',
      'Recipe 5',
      'Recipe 6',
      'Recipe 7',
    ];

    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Meal Planning'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Display recipes for each weekday
            for (int i = 0; i < days.length; i++)
              _buildDayCard(day: days[i], recipes: recipes, context: context),
        
            // Add a button to navigate to the recipe details or selection screen
            ElevatedButton(
              onPressed: () {
                // Navigate to the screen where users can select or view recipes in more detail
                // You need to implement the screen for recipe details or selection
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeSelectionScreen(),
                  ),
                );
              },
              child: Text('Select Recipes'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayCard({required String day, required List<String> recipes, required context}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05, vertical: 16.0),
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
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
                    color: Colors.white
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: null,
                  child: Text("Add Recipe"),
                ),
                SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: null,
                  child: Text("Delete All"),
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
              
              title: Text(recipe, style: TextStyle(color: Colors.white),),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Add your logic to delete the recipe
                },
              ),
              onTap: () {
                // Navigate to the screen where users can view the details of the selected recipe
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipeDetailScreenWeb(),
                  ),
                );
              },
            ),
        ],
      ),
    ),
  );
}

}

class RecipeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Implement the screen where users can select or view recipes in more detail
    // You can use similar structures as the MealPlanningScreen
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Selection'),
      ),
      body: Center(
        child: Text('Recipe Selection Screen'),
      ),
    );
  }
}
