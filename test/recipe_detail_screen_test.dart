import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:network_image_mock/network_image_mock.dart';
void main() {
  late Uint8List imageData;
  late Recipe recipe;

  setUp(() async {
    final imageFile = File('assets/test_resources/image.png');
    imageData = await imageFile.readAsBytes();

    recipe = Recipe(ID: 1, name: 'Recipe 1', image: imageData, ingredients: '1*Ei, 1*Ei', description: 'Description 1', rating: 5, rating_amount: 1);
  });
  //setUpAll(() => HttpOverrides.global = null);
  testWidgets('RecipeDetailScreenWeb should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: RecipeDetailScreenWeb(recipe: recipe),
      ),
    );

    // Wait for the network images to load
    
      // Verify if the widget renders correctly.
      expect(find.text('Description'), findsOneWidget);
      expect(find.text('Ingredients'), findsOneWidget);
    
  });

}
