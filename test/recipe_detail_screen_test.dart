import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
void main() {
  late Uint8List imageData;
  late Recipe recipe;

  setUp(() async {
    final imageFile = File('assets/test_resources/image.png');
    imageData = await imageFile.readAsBytes();

    recipe = Recipe(ID: 1, name: 'Recipe 1', image: imageData, ingredients: '1*Ei, 1*Ei', description: 'Description 1', rating: 5, rating_amount: 1);
  });

  group('RecipeDetailScreen Tests', () {
  testWidgets('RecipeDetailScreenWeb should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: RecipeDetailScreenWeb(recipe: recipe),
      ),
    );
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Recipe: ${recipe.name}'), findsOneWidget);
      expect(find.byType(IngridientColumn), findsOneWidget);
      expect(find.byType(DescriptionColumn), findsOneWidget);
      expect(find.byType(ImageColumn), findsOneWidget);
    
  });

  
  testWidgets('RecipeDetailScreenWeb ingredients should work', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: RecipeDetailScreenWeb(recipe: recipe),
      ),
    );

    expect(find.byType(IngridientColumn), findsOneWidget);
    expect(find.byType(Ingridientitem), findsAny);
    expect(find.byIcon(CupertinoIcons.add), findsAny);
    expect(find.byKey(const Key("ing_name")), findsAny);
    expect(find.byKey(const Key("ing_measurement")), findsAny);
    expect(find.byIcon(Icons.trip_origin), findsAny);
  });

  
  testWidgets('RecipeDetailScreenWeb description should work', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: DescriptionColumn(
            widget: RecipeDetailScreenWeb(recipe: recipe),
          ),
        ),
      ),
    );

    // Verify that the DescriptionColumn widget is rendered.
    expect(find.byKey(const Key("descriptionColumn")), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text(recipe.description), findsOneWidget);
    expect(find.byType(SizedBox), findsOneWidget);
    expect(tester.getSize(find.byType(SizedBox)).height, 40); // Adjust the expected height as needed.
  });
    
  testWidgets('RecipeDetailScreenWeb Image should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ImageColumn(
            widget: RecipeDetailScreenWeb(recipe: recipe),
          ),
        ),
      ),
    );

    // Verify that the ImageColumn widget is rendered.
    expect(find.byKey(const Key("imageColumn")), findsOneWidget);
    expect(find.byType(Padding), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(ClipRRect), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
  

    testWidgets('RecipeDetailScreenWeb creator should render', (WidgetTester tester) async {
    // Build our widget and trigger a frame.

        await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CreatorRecipe(
            widget: RecipeDetailScreenWeb(recipe: recipe),
          ),
        ),
      ),
    );

    // Verify that the CreatorRecipe widget is rendered.
    expect(find.byKey(const Key("RecipeCreator")), findsOneWidget);
    expect(find.byKey(const Key("profilePicture")), findsOneWidget);
    expect(find.text('Ratings: ${recipe.rating_amount}'), findsOneWidget); // Replace '5' with the expected rating amount.

    // Verify the number of stars based on the expected rating.
    expect(find.byIcon(Icons.star), findsNWidgets(5));
  });
 
  });
}