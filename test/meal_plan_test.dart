import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/utils/meal_plan_storage.dart';

void main() {
  group("Meal Plan Testing", () { 
  testWidgets('MealPlanningScreen Appbar test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: MealPlanningScreen(),
    ));

    // Verify that the MealPlanningScreen is rendered
    expect(find.byKey(Key("mealplanappbar")), findsOneWidget);
  });

  testWidgets('MealPlanningScreen AlertDialog test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: MealPlanningScreen(),
    ));

    expect(find.text('Add'), findsExactly(7));

    // Example: Tap the 'Add Recipe' button and wait for the dialog to appear
    await tester.tap(find.text('Add').first);
    await tester.pumpAndSettle();

    // Verify that the dialog is displayed
    expect(find.byType(AlertDialog), findsOneWidget);

    // Example: Test if the 'OK' button is displayed in the dialog
    expect(find.text('OK'), findsOneWidget);

    expect(find.byKey(Key("RecipeDropDown")),findsOneWidget);

    // Example: Test if the 'Cancel' button is displayed in the dialog
    expect(find.text('Cancel'), findsOneWidget);

    // Example: Tap the 'Cancel' button and wait for the dialog to close
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    // Verify that the dialog is closed
    expect(find.byType(AlertDialog), findsNothing);

  });

    testWidgets('MealPlanningScreen DeleteButtons test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: MealPlanningScreen(),
    ));

    expect(find.text('Monday'), findsOneWidget);
    await tester.tap(find.text('Monday'));
    await tester.pumpAndSettle();

    expect(find.byKey(Key("DeleteIconButtonList")), findsAny);
    await tester.tap(find.byKey(Key("DeleteIconButtonList")).first);
    await tester.pumpAndSettle();

    expect(find.text('Delete All'), findsExactly(7));

    // Example: Tap the 'Add Recipe' button and wait for the dialog to appear
    await tester.tap(find.text('Delete All').first);
    await tester.pumpAndSettle();

  });

    testWidgets('MealPlanningScreen Card test', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MaterialApp(
      home: MealPlanningScreen(),
    ));

    expect(find.text('Monday'), findsOneWidget);
    expect(find.text('Tuesday'), findsOneWidget);
    expect(find.text('Wednesday'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('Friday'), findsOneWidget);
    expect(find.text('Saturday'), findsOneWidget);
    expect(find.text('Sunday'), findsOneWidget);

  });


  });
}
