import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_organizer_frontend/screens/profile_screen.dart';

void main() {
  group('UserProfile', () {
    test('should create UserProfile correctly', () {
      final userProfile = UserProfile(
        name: 'Test User',
        profileImage: 'assets/images/test.jpg',
        likedRecipes: 5,
        createdRecipes: 3,
      );

      expect(userProfile.name, 'Test User');
      expect(userProfile.profileImage, 'assets/images/test.jpg');
      expect(userProfile.likedRecipes, 5);
      expect(userProfile.createdRecipes, 3);
    });
  });

  group('UserProfilePage', () {
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
    });
  });
}