// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:recipe_organizer_frontend/utils/secure_storage.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';

class FavoritedRecipesStorage {
  final SecureStorage _secureStorage = SecureStorage();
  final String _keyFavoritedRecipes = 'favorited_recipes';

  Future<void> addRecipe(Recipe recipe) async {
    final List<Recipe> favoritedRecipes = await getFavoritedRecipes();
    favoritedRecipes.add(recipe);
    await _secureStorage.write(
      key: _keyFavoritedRecipes,
      value: _encodeFavoritedRecipes(favoritedRecipes),
    );
  }

  Future<void> removeRecipe(Recipe recipe) async {
    final List<Recipe> favoritedRecipes = await getFavoritedRecipes();
    favoritedRecipes.removeWhere((r) => r.ID == recipe.ID);
    await _secureStorage.write(
      key: _keyFavoritedRecipes,
      value: _encodeFavoritedRecipes(favoritedRecipes),
    );
  }

  Future<List<Recipe>> getFavoritedRecipes() async {
    final String? favoritedRecipesString = await _secureStorage.read(key: _keyFavoritedRecipes);
    return _decodeFavoritedRecipes(favoritedRecipesString ?? '[]');
  }

  Future<List<int>> getFavoritedRecipesId() async {
    final List<Recipe> favoritedRecipes = await getFavoritedRecipes();
    return favoritedRecipes.map((recipe) => recipe.ID).toList();
  }

  String _encodeFavoritedRecipes(List<Recipe> favoritedRecipes) {
    return json.encode(favoritedRecipes.map((recipe) => recipe.toJson()).toList());
  }

  List<Recipe> _decodeFavoritedRecipes(String favoritedRecipesString) {
    try {
      final List<dynamic> decodedList = json.decode(favoritedRecipesString);
      return decodedList.map<Recipe>((item) => Recipe.fromJson(item)).toList();
    } catch (e) {
      print('Error decoding favorited recipes: $e');
      return [];
    }
  }

  // reset all favorited recipes
  Future<void> reset() async {
    await _secureStorage.write(
      key: _keyFavoritedRecipes,
      value: _encodeFavoritedRecipes([]),
    );
  }
}