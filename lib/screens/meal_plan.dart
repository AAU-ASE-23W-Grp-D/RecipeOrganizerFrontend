import 'package:flutter/material.dart';
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
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05,vertical:16.0),
      child: Card(
        margin: EdgeInsets.all(8),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width*0.05,vertical:16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                day,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              // Display the list of recipes for the day
              for (String recipe in recipes)
                ListTile(
                  title: Text(recipe),
                  // You can add onTap logic to navigate to the recipe details screen
                  onTap: () {
                    // Navigate to the screen where users can view the details of the selected recipe
                    // You need to implement the screen for recipe details
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
