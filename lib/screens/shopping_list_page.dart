import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';

class IngredientListItem extends StatelessWidget {
  final List<String> ingredients;
  final VoidCallback onDelete;
  final VoidCallback onBuy;

  IngredientListItem({
    required this.ingredients,
    required this.onDelete,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.2,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: primary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ingredients[0],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                ingredients[1],
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: onBuy,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ShoppingListScreen extends StatefulWidget {
  @override
  _ShoppingListScreenState createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  List<List<String>> ingredientsList = [
    ['Ingredient 1', 'Quantity 1'],
    ['Ingredient 2', 'Quantity 2'],
    ['Ingredient 3', 'Quantity 3'],
    // Add more ingredients as needed
  ];

  void deleteItem(int index) {
    setState(() {
      ingredientsList.removeAt(index);
    });
  }

  void deleteAllItems() {
    setState(() {
      ingredientsList.clear();
    });
  }

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
            TextButton(
              onPressed: deleteAllItems,
              child: Text('Delete All'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: ingredientsList.length,
                itemBuilder: (context, index) {
                  return IngredientListItem(
                    ingredients: ingredientsList[index],
                    onDelete: () => deleteItem(index),
                    onBuy: () {
                      // Add your logic for handling "Bought" action
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
