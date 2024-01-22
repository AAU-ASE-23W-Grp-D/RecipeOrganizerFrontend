import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/add_recipe_screen.dart';

void main() {
  group("UI Elements", () {
    testWidgets('AddRecipePage UI elements', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
        home: AddRecipePage(recipeName: 'Test Recipe')
    ));

    await tester.pumpAndSettle();

    // Verify that our widget has all UI elements.
    expect(find.text("Save Recipe"), findsOneWidget);
    expect(find.text("Recipe Description"), findsOneWidget);
    expect(find.text("Ingredients"), findsOneWidget);
    expect(find.text("Pick Image"), findsOneWidget);
    });
  });



  // Add more tests for other widgets and interactions.
}