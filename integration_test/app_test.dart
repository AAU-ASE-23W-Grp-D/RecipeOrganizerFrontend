import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/main.dart' as app;
import 'package:integration_test/integration_test.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/screens/profile_screen.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_screen.dart';
import 'package:recipe_organizer_frontend/screens/liked_recipes_screen.dart';
import 'package:recipe_organizer_frontend/screens/add_recipe_screen.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  Future<void> login(WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'testUser2');
    await Future.delayed(const Duration(seconds: 1));
    await tester.enterText(find.byType(TextFormField).at(1), '12345678');
    await Future.delayed(const Duration(seconds: 1));
    await tester.tap(find.byKey(const Key('loginButton')));
    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 3));
    expect(find.byType(ResponsiveNavBarPage), findsOneWidget);
  }

  group('Full App Test', () {
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

    testWidgets('Test if you can navigate to profile and back', (WidgetTester tester) async {
      await login(tester);

      //Open the popupmenu and navigate to profile
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      await tester.tap(find.byWidgetPredicate((widget) => widget is PopupMenuItem<Menu> && widget.value == Menu.itemOne));
      await tester.pumpAndSettle();

      expect(find.byType(UserProfilePage), findsOneWidget);

      //navigate back to homescreen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(ResponsiveNavBarPage), findsOneWidget);
    });

    testWidgets('Test if you can navigate to recipe detail and back', (WidgetTester tester) async {
      await login(tester);

      //navigate to recipe detail
      await tester.tap(find.byIcon(CupertinoIcons.search).first);
      await tester.pumpAndSettle();
      expect(find.byType(RecipeDetailScreenWeb), findsOneWidget);

      //navigate back to homescreen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(ResponsiveNavBarPage), findsOneWidget);
    });

    testWidgets('Test if you can navigate to the liked recipes and back', (WidgetTester tester) async {
      await login(tester);

      //navigate to liked recipes
      //Delayed because the backend needs some time to load the recipes
      await Future.delayed(const Duration(seconds: 2));
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();

      await tester.tap(find.byWidgetPredicate((widget) => widget is PopupMenuItem<Menu> && widget.value == Menu.itemTwo));
      await tester.pumpAndSettle();

      expect(find.byType(LikedRecipesPage), findsOneWidget);

      //navigate back to homescreen
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();
      expect(find.byType(ResponsiveNavBarPage), findsOneWidget);
    });

    testWidgets('Test if you can add a new recipe', (WidgetTester tester) async {
      await login(tester);

      //navigate to profile page
      await tester.tap(find.byIcon(Icons.person));
      await tester.pumpAndSettle();
      await tester.tap(find.byWidgetPredicate((widget) => widget is PopupMenuItem<Menu> && widget.value == Menu.itemOne));
      await tester.pumpAndSettle();
      expect(find.byType(UserProfilePage), findsOneWidget);

      //Click FAB
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      //Expect a popup to appear
      expect(find.byType(AlertDialog), findsOneWidget);
      await tester.enterText(find.byType(TextField).first, 'Test Recipe 101');
      await tester.pumpAndSettle();
      await tester.tap(find.text("Add"));

      //Expect the recipe screen
      await tester.pumpAndSettle();
      expect(find.byType(AddRecipePage), findsOneWidget);

      //Add recipe data
      //Add ingredients
      await tester.enterText(find.byKey(const Key("ingredientTextField")), '100ml Milk');
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key("addIngredientButton")));

      //Add description
      await tester.enterText(find.byKey(const Key("descriptionTextField")), 'This is a testDescription');
      await tester.pumpAndSettle();

      //Add image
      await tester.tap(find.byKey(const Key("uploadImageButton")));
      await tester.pumpAndSettle();

      //Save Recipe
      await tester.tap(find.text("Save Recipe"));
      await tester.pumpAndSettle();

      //Expect success alert dialog (Delay for backend response time)
      await Future.delayed(const Duration(seconds: 2));
      expect(find.byType(AlertDialog), findsOneWidget);
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
