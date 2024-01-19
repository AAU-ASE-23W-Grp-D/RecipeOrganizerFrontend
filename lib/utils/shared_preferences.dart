import 'dart:convert';

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


class SharedPreferencesMealPlanning {
  SharedPreferences? _prefs;

  Future<void> open() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> insertRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = getMealPlanning() ?? {};
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.add(recipe);
    mealPlanning[day] = recipes;
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  Future<void> deleteRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = getMealPlanning() ?? {};
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.remove(recipe);
    mealPlanning[day] = recipes;
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  Future<void> deleteAllRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = getMealPlanning() ?? {};
    mealPlanning.remove(day);
    await _prefs!.setString('meal_planning', _encodeMealPlanning(mealPlanning));
  }

  List<String>? getRecipes(String day) {
    final Map<String, List<String>> mealPlanning = getMealPlanning() ?? {};
    return mealPlanning[day];
  }

  Map<String, List<String>>? getMealPlanning() {
    final String? mealPlanningString = _prefs!.getString('meal_planning');
    if (mealPlanningString != null && mealPlanningString.isNotEmpty) {
      return _decodeMealPlanning(mealPlanningString);
    }
    return null;
  }

  String _encodeMealPlanning(Map<String, List<String>> mealPlanning) {
    return mealPlanning.keys.fold<Map<String, dynamic>>(
      {},
      (Map<String, dynamic> json, String key) {
        json[key] = mealPlanning[key];
        return json;
      },
    ).toString();
  }

  Map<String, List<String>> _decodeMealPlanning(String mealPlanningString) {
    final Map<String, dynamic> decodedMap = Map<String, dynamic>.from(
      Map<String, dynamic>.from(
        Map<String, dynamic>.from(
          Map<String, dynamic>.from(
            json.decode(mealPlanningString),
          ),
        ),
      ),
    );
    return decodedMap.map(
      (key, value) => MapEntry(key, List<String>.from(value)),
    );
  }
}

