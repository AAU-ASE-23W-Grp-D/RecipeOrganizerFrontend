
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';

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

//Ich hab die Integration Test auskommentiert weil sie auf Github noch nicht funktionieren
//Lokal sollte es gehen wenn das Backend läuft.
    /*testWidgets('Test if the meal plan works', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'testUser2');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), '12345678');
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
    });

    testWidgets('Test if the meal plan add alertdialog works', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'testUser2');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), '12345678');
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(const Key('loginButton')));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(ResponsiveNavBarPage), findsOneWidget);

          await tester.tap(find.text("Meal Plan").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          expect(find.byType(MealPlanningScreen), findsOneWidget);

          await tester.tap(find.text("Add").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          expect(find.byType(AlertDialog), findsOneWidget);
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.byKey(Key("RecipeDropDown")));
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.tap(find.text("Brot").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await tester.tap(find.text("OK").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          await tester.tap(find.text("Monday"));
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.text("Brot"), findsOne);

          await tester.tap(find.text("Delete All").first);
          await Future.delayed(const Duration(seconds: 2));
          await tester.pumpAndSettle();

          expect(find.text("Brot"), findsNothing);


//.\run_integration_tests.bat
    });

        testWidgets('Test if the shopping list works', (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(0), 'testUser2');
          await Future.delayed(const Duration(seconds: 2));
          await tester.enterText(find.byType(TextFormField).at(1), '12345678');
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
    });
//.\run_integration_tests.bat*/
  });
}
