import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';
import 'package:recipe_organizer_frontend/screens/liked_recipes_screen.dart';
import 'package:recipe_organizer_frontend/screens/add_recipe_screen.dart';

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
  final UserProfile userProfile;


  const UserProfilePage({super.key, required this.userProfile});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: ListView(
              //crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(userProfile.profileImage),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      userProfile.name,
                      style: const TextStyle(fontSize: 24),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LikedRecipesPage(
                            profile: Profile(
                              name: userProfile.name,
                              profileImage: userProfile.profileImage,
                              likedRecipes: userProfile.likedRecipes,
                            )
                        )
                        )
                        );
                      },
                      child: Text(
                        'Liked Recipes: ${userProfile.likedRecipes}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      'Created Recipes: ${userProfile.createdRecipes}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                ),
                const Padding(
                    padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My Recipes',
                    style: TextStyle(fontSize: 18),
                  )
                ),
                /*
                * Placeholder for recipes:
                */
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: GridB(), //Insert own gridview here
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String recipeName = ''; // Initialize an empty string

              return AlertDialog(
                title: const Text("Add Recipe"),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(labelText: 'Recipe Name'),
                        onChanged: (value) {
                          recipeName = value; // Update recipeName when the text changes
                        },
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddRecipePage(recipeName: recipeName),
                            ),
                          );
                        },
                        child: const Text("Add"),
                      ),
                    ],
                  ),
                )

              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

}
