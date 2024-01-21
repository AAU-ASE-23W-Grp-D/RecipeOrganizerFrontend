import 'dart:convert';

import 'package:recipe_organizer_frontend/utils/secure_storage.dart';

class SecureStorageMealPlanning {
  final SecureStorage _secureStorage = SecureStorage();
  final String _keyMealPlan = 'meal_planning';

  Future<void> insertRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.add(recipe);
    mealPlanning[day] = recipes;
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  Future<void> deleteRecipe(String day, String recipe) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    final List<String> recipes = mealPlanning[day] ?? [];
    recipes.remove(recipe);
    mealPlanning[day] = recipes;
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  Future<void> deleteAllRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    mealPlanning.remove(day);
    await _secureStorage.write(
      key: _keyMealPlan,
      value: _encodeMealPlanning(mealPlanning),
    );
  }

  Future<List<String>> getRecipes(String day) async {
    final Map<String, List<String>> mealPlanning = await getMealPlanning()!;
    return mealPlanning[day] ?? [];
  }

  Future<Map<String, List<String>>> getMealPlanning() async {
    final String? mealPlanningString = await _secureStorage.read(key: _keyMealPlan);
    return _decodeMealPlanning(mealPlanningString ?? '{}');
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
