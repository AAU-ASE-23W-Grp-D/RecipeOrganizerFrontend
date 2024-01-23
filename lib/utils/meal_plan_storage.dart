import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:recipe_organizer_frontend/utils/secure_storage.dart';

// Class responsible for managing meal planning data in secure storage
class SecureStorageMealPlanning {
  final SecureStorage _secureStorage = SecureStorage();
  final String _keyMealPlan = 'meal_planning';

  // Inserts a recipe into the meal planning data
  Future<void> insertRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning();
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.add(recipe);
    mealPlanning[day] = recipes;
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  // Deletes a recipe from the meal planning data
  Future<void> deleteRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning();
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.remove(recipe);
    mealPlanning[day] = recipes;
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  // Deletes all recipes for a specific day from the meal planning data
  Future<void> deleteAllRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning();
    mealPlanning.remove(day);
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  // Gets the list of recipes for a specific day from the meal planning data
  Future<List<String>> getRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning();
    return mealPlanning[day] ?? [];
  }

  // Gets the entire meal planning data
  Future<Map<String, List<String>>> getMealPlanning() async {
    final String? mealPlanningString =
        await _secureStorage.read(key: _keyMealPlan);
    return _decodeMealPlanning(mealPlanningString ?? '{}');
  }

  // Encodes the meal planning data to a JSON string
  String _encodeMealPlanning(Map<String, List<String>> mealPlanning) {
    return json.encode(mealPlanning);
  }

  // Decodes the JSON string to retrieve the meal planning data
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
      // Handle decoding errors, print in debug mode
      if (kDebugMode) {
        print('Error decoding meal planning: $e');
      }
      return {};
    }
  }
}
