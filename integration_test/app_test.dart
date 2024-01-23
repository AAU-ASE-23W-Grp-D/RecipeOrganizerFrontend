import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Full App Testing', () {
    testWidgets("Register and Navigate to Login", (WidgetTester tester) async {
      //Add register logic here
    });

    testWidgets("Login and Navigate to Home", (WidgetTester tester) async {
      //Add login logic here
    });

    testWidgets('Test if the app opens', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Test if you can navigate to profile', (WidgetTester tester) async {

    });

    /*testWidgets('Test if the meal plan works', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'sandro');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'sandro');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('loginButton')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(ResponsiveNavBarPage), findsOneWidget);

          await tester.tap(find.byIcon(CupertinoIcons.add).first);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(AlertDialog), findsOneWidget);
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text("Assign"));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.text("Meal Plan").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.byType(MealPlanningScreen), findsOneWidget);

          await tester.tap(find.text("Monday"));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byIcon(Icons.delete), findsAtLeast(1));
          await tester.tap(find.byIcon(Icons.delete));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.delete), findsNothing);
//.\run_integration_tests.bat
    });*/

        testWidgets('Test if the shopping list works', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'sandro');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), 'sandro');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('loginButton')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(ResponsiveNavBarPage), findsOneWidget);

          await tester.tap(find.byIcon(CupertinoIcons.search).first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.byType(RecipeDetailScreenWeb), findsOneWidget);

          await tester.tap(find.byIcon(CupertinoIcons.add).first);
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.byTooltip("Back"));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));

          await tester.tap(find.text("Shopping List").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.byType(ShoppingListScreen), findsOneWidget);

          expect(find.byType(IngredientListItem), findsAtLeast(1));
          expect(find.byIcon(Icons.delete), findsAtLeast(1));
          await tester.tap(find.byIcon(Icons.delete));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.byIcon(Icons.delete), findsNothing);
//.\run_integration_tests.bat
    });

  });
}
