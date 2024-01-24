// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'dart:convert';
import 'dart:typed_data';

class Recipe {
  final int ID;
  final String name;
  final String ingredients;
  final String description;
  final int rating;
  final int rating_amount;
  final Uint8List image;

  const Recipe({
    required this.ID,
    required this.name,
    required this.ingredients,
    required this.description,
    required this.rating,
    required this.rating_amount,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int ID,
        'name': String name,
        'ingredients': String ingredients,
        'description': String description,
        'rating': int rating,
        'rating_amount': int rating_amount,
        'image': String image,
      } =>
        Recipe(
          ID: ID,
          name: name,
          ingredients: ingredients,
          description: description,
          rating: rating,
          rating_amount: rating_amount,
          image: base64.decode(image),
        ),
      _ => throw const FormatException('Failed to load recipe.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': ID,
      'name': name,
      'ingredients': ingredients,
      'description': description,
      'rating': rating,
      'rating_amount': rating_amount,
      'image': base64.encode(image),
    };
  }
}
