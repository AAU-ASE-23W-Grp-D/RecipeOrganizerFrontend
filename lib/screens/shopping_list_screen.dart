import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IngredientListItem extends StatelessWidget {
  final ShoppingListItem ingredients;
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
                ingredients.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                ingredients.quantity,
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
  SharedPreferencesShoppingList _databaseHelper = SharedPreferencesShoppingList();
  List<ShoppingListItem> ingredientsList = [];

  @override
  void initState() {
    super.initState();
    //_insertExample();
    _updateShoppingList();
  }

  void _updateShoppingList() async {
    await _databaseHelper.open();
    List<ShoppingListItem> list = await _databaseHelper.getShoppingListItems();
    
    setState(() {
      ingredientsList = list;
    });
  }

  void _insertExample() async {
        await _databaseHelper.open();
    await _databaseHelper.insertShoppingListItem2("example","example");
  }

  void deleteItem(int index) async {
    await _databaseHelper.open();
    await _databaseHelper.deleteShoppingListItem(index);
    _updateShoppingList();
  }

  void deleteAllItems() async {
    await _databaseHelper.open();
    await _databaseHelper.deleteAllShoppingListItems();
    _updateShoppingList();
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
