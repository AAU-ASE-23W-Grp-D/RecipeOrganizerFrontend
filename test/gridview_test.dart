import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';

class MockApi {
  Future<List<Recipe>> Function() fetchUserRecipes;
  MockApi({required this.fetchUserRecipes});
}

void main() {
  late MockApi mockApi;
  late Uint8List imageData;

  setUp(() async {
    final imageFile = File('assets/test_resources/image.png');
    imageData = await imageFile.readAsBytes();

    mockApi = MockApi(fetchUserRecipes: () async => [
      Recipe(ID: 1, name: 'Recipe 1', image: imageData, ingredients: 'Ingredients 1', description: 'Description 1', rating: 5, rating_amount: 1),
      Recipe(ID: 2, name: 'Recipe 2', image: imageData, ingredients: 'Ingredients 2', description: 'Description 2', rating: 4, rating_amount: 1),
      Recipe(ID: 3, name: 'Recipe 3', image: imageData, ingredients: 'Ingredients 3', description: 'Description 3', rating: 3, rating_amount: 1),
    ]);
  });

  group('GridB', () {
    testWidgets('GridView loads data after backend call', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GridB(fetchFunction: mockApi.fetchUserRecipes),
      ));

      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.text('Recipe 1'), findsOneWidget);
      expect(find.text('Recipe 2'), findsOneWidget);
      expect(find.text('Recipe 3'), findsOneWidget);
    });
  });

  group('GridB', () {
    testWidgets('GridView shows error message when backend call fails', (WidgetTester tester) async {
      mockApi = MockApi(fetchUserRecipes: () async {
        throw Exception('Failed to fetch recipes');
      });

      await tester.pumpWidget(MaterialApp(
        home: GridB(fetchFunction: mockApi.fetchUserRecipes),
      ));

      await tester.pumpAndSettle();

      expect(find.text('Error: Exception: Failed to fetch recipes'), findsOneWidget);
    });

    group('UI Test', () {
      testWidgets('Each element and icon is present', (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(
          home: GridB(fetchFunction: mockApi.fetchUserRecipes),
        ));

        await tester.pumpAndSettle();

        // Check for GridView
        expect(find.byType(GridView), findsOneWidget);

        // Check for IconButton
        expect(find.byType(IconButton), findsWidgets);

        // Check for Icons
        expect(find.byIcon(CupertinoIcons.heart_fill), findsWidgets);
        expect(find.byIcon(CupertinoIcons.search), findsWidgets);
        expect(find.byIcon(CupertinoIcons.add), findsWidgets);
      });
    });
  });




}