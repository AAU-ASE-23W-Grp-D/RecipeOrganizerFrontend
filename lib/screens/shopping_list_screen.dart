import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/utils/shopping_list_storage.dart';

class IngredientListItem extends StatelessWidget {
  final ShoppingListItem ingredients;
  final VoidCallback onDelete;
  final VoidCallback onBuy;

  const IngredientListItem({super.key, 
    required this.ingredients,
    required this.onDelete,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
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
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                ingredients.quantity,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: onBuy,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
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
  const ShoppingListScreen({super.key});

  @override
  ShoppingListScreenState createState() => ShoppingListScreenState();
}

class ShoppingListScreenState extends State<ShoppingListScreen> {
  final SecureStorageShoppingList _slStorage = SecureStorageShoppingList();
  List<ShoppingListItem> ingredientsList = [];

  @override
  void initState() {
    super.initState();
    //_insertExample();
    _updateShoppingList();
  }

  void _updateShoppingList() async {
    List<ShoppingListItem> list = await _slStorage.getShoppingListItems();

    setState(() {
      ingredientsList = list;
    });
  }

  void deleteItem(int index) async {
    await _slStorage.deleteShoppingListItem(index);
    _updateShoppingList();
  }

  void deleteAllItems() async {
    await _slStorage.deleteAllShoppingListItems();
    _updateShoppingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Shopping List',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: deleteAllItems,
              child: const Text('Delete All'),
            ),
            const SizedBox(height: 16),
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
