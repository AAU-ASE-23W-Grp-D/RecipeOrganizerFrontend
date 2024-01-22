import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/widgets/footer.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';

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

      // Verify that the menu items are rendered
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Recent:'), findsOneWidget);
      expect(find.text('Meal Plan'), findsOneWidget);
      expect(find.text('Shopping List'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsAny);
      expect(find.byType(Footer), findsOne);
      expect(find.byType(GridB), findsAny);
    });

    testWidgets('Tap on menu item navigates to the correct screen', (WidgetTester tester) async {
      // Build our app and trigger a frame
      await tester.pumpWidget(
        MaterialApp(
          home: ResponsiveNavBarPage(),
        ),
      );

      await tester.tap(find.byType(CircleAvatar));

      expect(find.text("Profile"), findsOneWidget);
      expect(find.text("Sign Out"), findsOneWidget);
      expect(find.text("Liked Recipes"), findsOneWidget);

    });

    // Add more tests as needed
  });
}
