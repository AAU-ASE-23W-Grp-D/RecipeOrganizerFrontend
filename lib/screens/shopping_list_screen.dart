import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientListItem extends StatelessWidget {
  final List<String> ingredients;
  final VoidCallback onDelete;
  final VoidCallback onBuy;

  IngredientListItem({
    required this.ingredients,
    required this.onDelete,
    required this.onBuy,
  });


    static String ingredientsToString(List<List<String>> ingredientsList) {
    // Implement the logic to convert the ingredientsList to a string
    // For example, join the ingredients into a single string
    return ingredientsList.map((ingredients) => ingredients.join(' ')).join(', ');
  }

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
  List<List<String>> ingredientsList = [];
  final _prefsKey = 'shoppingList';

  @override
  void initState() {
    super.initState();
    // Load the shopping list from local storage when the widget is created
    _loadShoppingList();
  }

  void _loadShoppingList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedShoppingList = prefs.getString(_prefsKey);

    if (savedShoppingList != null && savedShoppingList.isNotEmpty) {
      setState(() {
        ingredientsList = savedShoppingList.split('; ').map((item) => item.split(', ')).toList();
      });
    }
  }

void _saveShoppingList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(_prefsKey, IngredientListItem.ingredientsToString(ingredientsList));
}


  void deleteItem(int index) {
    setState(() {
      ingredientsList.removeAt(index);
      _saveShoppingList(); // Save the updated shopping list
    });
  }

  void deleteAllItems() {
    setState(() {
      ingredientsList.clear();
      _saveShoppingList(); // Save the updated shopping list
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