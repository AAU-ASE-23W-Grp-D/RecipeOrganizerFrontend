import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String profileImage;
  final int likedRecipes;
  final int createdRecipes;

  UserProfile({
    required this.name,
    required this.profileImage,
    required this.likedRecipes,
    required this.createdRecipes,
  });
}

class UserProfilePage extends StatelessWidget {
  UserProfile userProfile;


  UserProfilePage({required this.userProfile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // User Profile Picture
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(userProfile.profileImage),
            ),

            SizedBox(height: 16),

            // Liked Recipes Count
            Text(
              'Liked Recipes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userProfile.likedRecipes.toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            SizedBox(height: 16),

            // Created Recipes Count
            Text(
              'Created Recipes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              userProfile.createdRecipes.toString(),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
