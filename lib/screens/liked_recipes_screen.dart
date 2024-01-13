import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/gridview.dart';

class Profile {
  final String name;
  final String profileImage;
  final int likedRecipes;

  Profile({
    required this.name,
    required this.profileImage,
    required this.likedRecipes,
  });
}

class LikedRecipesPage extends StatelessWidget {
  final Profile profile;

  const LikedRecipesPage({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Liked Recipes'),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
        
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(profile.profileImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                profile.name,
                style: const TextStyle(fontSize: 24),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(
                  'Liked Recipes: ${profile.likedRecipes}',
                  style: const TextStyle(fontSize: 12),
                ),
            ),
        
            const Divider(
              thickness: 2,
            ),
        
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Liked Recipes',
                style: TextStyle(fontSize: 18),
              ),
            ),
        
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: GridB(),
            )
          ]
        ),
      )
    );
  }
}

