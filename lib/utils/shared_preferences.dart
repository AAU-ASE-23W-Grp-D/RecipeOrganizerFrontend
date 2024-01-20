import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/models/user.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';
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
  String? _userId;
  final String _keyShoppingList = "shopping_list";

  SharedPreferencesShoppingList(this._userId);

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

    String _getUserKey(String key) {
    // Append the user identifier to the key
    return '$_userId:$key';
  }

  Future<void> insertShoppingListItem(ShoppingListItem item) async {
    final List<String> shoppingList = _prefs!.getStringList(_getUserKey(_keyShoppingList)) ?? [];
    shoppingList.add('${item.name}: ${item.quantity}');
    await _prefs!.setStringList(_getUserKey(_keyShoppingList), shoppingList);
  }

  Future<void> insertShoppingListItem2(String name, String quantity) async {
    final List<String> shoppingList = _prefs!.getStringList(_getUserKey(_keyShoppingList)) ?? [];
    shoppingList.add('${name}: ${quantity}');
    await _prefs!.setStringList(_getUserKey(_keyShoppingList), shoppingList);
  }

    Future<void> deleteShoppingListItem(int index) async {
    final List<String> shoppingList = _prefs!.getStringList(_getUserKey(_keyShoppingList)) ?? [];
    if (index >= 0 && index < shoppingList.length) {
      shoppingList.removeAt(index);
      await _prefs!.setStringList(_getUserKey(_keyShoppingList), shoppingList);
    }
  }

  Future<void> deleteAllShoppingListItems() async {
    await _prefs!.remove(_getUserKey(_keyShoppingList));
  }

  Future<List<ShoppingListItem>> getShoppingListItems() async {
    final List<String> shoppingList = _prefs!.getStringList(_getUserKey(_keyShoppingList)) ?? [];
    return shoppingList.map((item) {
      final parts = item.split(': ');
      return ShoppingListItem(
        name: parts[0],
        quantity: parts[1],
      );
    }).toList();
  }
}

class SharedPreferencesMealPlanning {
  SharedPreferences? _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> insertRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.add(recipe);
    mealPlanning[day] = recipes;
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  Future<void> deleteRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.remove(recipe);
    mealPlanning[day] = recipes;
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  Future<void> deleteAllRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    mealPlanning.remove(day);
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  Future<List<String>> getRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    return mealPlanning[day] ?? [];
  }

  Future<Map<String, List<String>>> getMealPlanning() async {
    final String mealPlanningString = _prefs!.getString('meal_planning') ?? '{}';
    return _decodeMealPlanning(mealPlanningString);
  }

  String _encodeMealPlanning(Map<String, List<String>> mealPlanning) {
    return json.encode(mealPlanning);
  }

Map<String, List<String>> _decodeMealPlanning(String mealPlanningString) {
  try {
    final Map<String, dynamic> decodedMap = json.decode(mealPlanningString);
    final Map<String, List<String>> result = {};

    decodedMap.forEach((key, value) {
      if (value is List<dynamic>) {
        result[key] = value.cast<String>();
      }
    });

    return result;
  } catch (e) {
    print('Error decoding meal planning: $e');
    return {};
  }
}
}
