import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/profile_screen.dart';
import 'package:recipe_organizer_frontend/screens/add_recipe_screen.dart';

void main() {
  group('UserProfile', () {
    test('should create UserProfile correctly', () {
      final userProfile = UserProfile(
        name: 'Test User',
        profileImage: 'assets/user_icon.png',
        likedRecipes: 5,
        createdRecipes: 3,
      );

      expect(userProfile.name, 'Test User');
      expect(userProfile.profileImage, 'assets/user_icon.png');
      expect(userProfile.likedRecipes, 5);
      expect(userProfile.createdRecipes, 3);
    });

    testWidgets('should render UserProfilePage correctly', (WidgetTester tester) async {
      final userProfile = UserProfile(
        name: 'Test User',
        profileImage: 'assets/user_icon.png',
        likedRecipes: 5,
        createdRecipes: 3,
      );

      await tester.pumpWidget(MaterialApp(
        home: UserProfilePage(userProfile: userProfile),
      ));

      expect(find.text('Test User'), findsOneWidget);
      expect(find.text('Liked Recipes: 5'), findsOneWidget);
      expect(find.text('Created Recipes: 3'), findsOneWidget);
      expect(find.widgetWithIcon(FloatingActionButton, Icons.add), findsOneWidget);
    });
  });

    group("FAB Actions", () {
    testWidgets('navigates to AddRecipePage when FAB is pressed', (WidgetTester tester) async {
      final userProfile = UserProfile(
        name: 'Test User',
        profileImage: 'assets/user_icon.png',
        likedRecipes: 5,
        createdRecipes: 3,
      );

      await tester.pumpWidget(MaterialApp(
        home: UserProfilePage(userProfile: userProfile),
      ));

      await tester.tap(find.widgetWithIcon(FloatingActionButton, Icons.add));
      await tester.pump(const Duration(seconds: 1));

      await tester.enterText(find.byType(TextField), 'Test Recipe');

      await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
      await tester.pumpAndSettle();

      expect(find.byType(AddRecipePage), findsOneWidget);
    });

    testWidgets('cancels new recipe when clicking outside dialog', (WidgetTester tester) async {
      final userProfile = UserProfile(
        name: 'Test User',
        profileImage: 'assets/user_icon.png',
        likedRecipes: 5,
        createdRecipes: 3,
      );

      await tester.pumpWidget(MaterialApp(
        home: UserProfilePage(userProfile: userProfile),
      ));

      // Simulate the press on the FAB
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump(); // Pump once to open the dialog

      // Simulate the tap outside the dialog to close it
      await tester.tapAt(const Offset(0.0, 0.0)); // Taps at the top-left corner of the screen
      await tester.pump(); // Allow the closing animation to complete

      // Verify that the AddRecipePage was not pushed
      expect(find.byType(AddRecipePage), findsNothing);
    });
  });
}