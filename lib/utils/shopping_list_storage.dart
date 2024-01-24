import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:recipe_organizer_frontend/models/shopping_list_item.dart';
import 'package:recipe_organizer_frontend/utils/secure_storage.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';

// Class responsible for managing shopping list data in secure storage
class SecureStorageShoppingList {
  final String _keyShoppingList = "shopping_list";
  final SecureStorage _secureStorage = SecureStorage();
  final UserStorage user = UserStorage();

  // Inserts a shopping list item into the shopping list data
  Future<void> insertShoppingListItem(ShoppingListItem item) async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    shoppingList.add('${item.name}: ${item.quantity}');
    await _updateShoppingList(shoppingList);
  }

  // Alternative method to insert a shopping list item using name and quantity
  Future<void> insertShoppingListItem2(String name, String quantity) async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    shoppingList.add('$name: $quantity');
    await _updateShoppingList(shoppingList);
  }

  // Deletes a shopping list item at a specific index from the shopping list data
  Future<void> deleteShoppingListItem(int index) async {
    List<String> shoppingList = await _getShoppingList() ?? [];
    if (index >= 0 && index < shoppingList.length) {
      shoppingList.removeAt(index);
      await _updateShoppingList(shoppingList);
    }
  }

  // Deletes all shopping list items from the shopping list data
  Future<void> deleteAllShoppingListItems() async {
    await _secureStorage.delete(key: _keyShoppingList);
  }

  // Gets the list of shopping list items from the shopping list data
  Future<List<ShoppingListItem>> getShoppingListItems() async {
    final List<String> shoppingList = await _getShoppingList() ?? [];
    return shoppingList.map((item) {
      final parts = item.split(': ');
      return ShoppingListItem(
        name: parts[0],
        quantity: parts[1],
      );
    }).toList();
  }

  // Private method to retrieve the shopping list from secure storage
  Future<List<String>?> _getShoppingList() async {
    final String? shoppingListString =
        await _secureStorage.read(key: _keyShoppingList);
    return _decodeShoppingList(shoppingListString);
  }

  // Private method to update the shopping list in secure storage
  Future<void> _updateShoppingList(List<String> shoppingList) async {
    await _secureStorage.write(
      key: _keyShoppingList,
      value: _encodeShoppingList(shoppingList),
    );
  }

  // Private method to encode the shopping list to a JSON string
  String _encodeShoppingList(List<String> shoppingList) {
    return json.encode(shoppingList);
  }

  // Private method to decode the JSON string to retrieve the shopping list
  List<String>? _decodeShoppingList(String? shoppingListString) {
    try {
      final List<dynamic> decodedList = json.decode(shoppingListString ?? '[]');
      return decodedList.cast<String>();
    } catch (e) {
      // Handle decoding errors, print in debug mode
      if (kDebugMode) {
        print('Error decoding shopping list: $e');
      }
      return null;
    }
  }
}
