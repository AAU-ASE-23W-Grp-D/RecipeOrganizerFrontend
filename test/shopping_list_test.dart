import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/models/shopping_list_item.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_screen.dart';

void main() {
  group("Shopping List tests", () { 
  testWidgets('IngredientListItem should render correctly', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: IngredientListItem(
          ingredients: ShoppingListItem(name: "Test Ingredient", quantity: "Test Quantity"),
          onDelete: () {},
        ),
      ),
    );

    // Verify if the widget renders correctly.
    expect(find.text('Test Ingredient'), findsOneWidget);
    expect(find.text('Test Quantity'), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });

  testWidgets('ShoppingListScreen should render correctly', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: ShoppingListScreen(),
      ),
    );

    // Verify if the widget renders correctly.
    expect(find.text('Shopping List'), findsAny);
    expect(find.byType(TextButton), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('ShoppingListScreen should delete item when delete button is pressed', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: ShoppingListScreen(),
      ),
    );
    expect(find.byType(IngredientListItem), findsNothing);

    // Delete all items to the shopping list
    await tester.tap(find.byType(TextButton));
    await tester.pump();

    // Verify if the item is added
    expect(find.byType(IngredientListItem), findsNothing);
  });
  });
}
