import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';

class IngredientListItem extends StatelessWidget {
  final List<String> ingredients;

  IngredientListItem({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue), // Use your preferred color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ingredient information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ingredients[0], // Ingredient name
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                ingredients[1], // Ingredient quantity or any other information
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Spacer(), // Add Spacer to occupy available space
          // Icons for "Bought" and "Deleted"
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart), // Icon for "Bought"
                onPressed: () {
                  // Add your logic for handling "Bought" action
                },
              ),
              IconButton(
                icon: Icon(Icons.delete), // Icon for "Deleted"
                onPressed: () {
                  // Add your logic for handling "Deleted" action
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


class ShoppingListScreen extends StatelessWidget {
  final List<List<String>> ingredientsList = [
    ['Ingredient 1', 'Quantity 1'],
    ['Ingredient 2', 'Quantity 2'],
    ['Ingredient 3', 'Quantity 3'],
    // Add more ingredients as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Shopping List',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),

            // List of Ingredients
            Expanded(
              child: ListView.builder(
                itemCount: ingredientsList.length,
                itemBuilder: (context, index) {
                  return IngredientListItem(ingredients: ingredientsList[index]);
                },
              ),
            ),
          ],
        ),

      )
    );
  }
  
}