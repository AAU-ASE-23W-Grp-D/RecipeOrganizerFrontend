import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingListItem {
  int? id;
  String name;
  String quantity;

  ShoppingListItem({this.id, required this.name, required this.quantity});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
    };
  }
}
class SharedPreferencesShoppingList {
  SharedPreferences? _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> insertShoppingListItem(ShoppingListItem item) async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    shoppingList.add('${item.name}: ${item.quantity}');
    await _prefs!.setStringList('shopping_list', shoppingList);
  }

  Future<void> insertShoppingListItem2(String name, String quantity) async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    shoppingList.add('${name}: ${quantity}');
    await _prefs!.setStringList('shopping_list', shoppingList);
  }

    Future<void> deleteShoppingListItem(int index) async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    if (index >= 0 && index < shoppingList.length) {
      shoppingList.removeAt(index);
      await _prefs!.setStringList('shopping_list', shoppingList);
    }
  }

  Future<void> deleteAllShoppingListItems() async {
    await _prefs!.remove('shopping_list');
  }

  Future<List<ShoppingListItem>> getShoppingListItems() async {
    final List<String> shoppingList = _prefs!.getStringList('shopping_list') ?? [];
    return shoppingList.map((item) {
      final parts = item.split(': ');
      return ShoppingListItem(
        name: parts[0],
        quantity: parts[1],
      );
    }).toList();
  }
}


class SharedPreferencesMealPlan {
  SharedPreferences? _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

}
