import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';

void main() {
  group('ResponsiveNavBarPage Tests', () {
    testWidgets('Widget renders correctly', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveNavBarPage(),
        ),
      );

      // Verify that the appBar title is rendered
      expect(find.text('Recipe Organizer'), findsOneWidget);

      // Verify that the search bar is rendered
      expect(find.byType(TextField), findsOneWidget);

      // Verify that the menu items are rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Meal Plan'), findsOneWidget);
      expect(find.text('Shopping List'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('Tap on menu item navigates to the correct screen', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveNavBarPage(),
        ),
      );

      // Tap on "Meal Plan" menu item
      await tester.tap(find.text('Meal Plan'));
      await tester.pumpAndSettle();

      // Verify that the MealPlanningScreen is rendered
      expect(find.byType(MealPlanningScreen), findsOneWidget);

      // You can add similar tests for other menu items
    });

    // Add more tests as needed
  });
}
