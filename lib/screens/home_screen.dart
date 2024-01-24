// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/api.dart';
import 'package:recipe_organizer_frontend/utils/favorited_recipes_storage.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';
import 'package:recipe_organizer_frontend/widgets/footer.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/screens/profile_screen.dart';
import 'package:recipe_organizer_frontend/screens/liked_recipes_screen.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_screen.dart';

bool loggedIn = true;

class ResponsiveNavBarPage extends StatelessWidget {
  ResponsiveNavBarPage({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Future<List<Recipe>> futureRecipe = Api().fetchRecipes();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: const Footer(),
        appBar: navBar(isLargeScreen, context),
        drawer: isLargeScreen ? null : _drawer(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  constraints: const BoxConstraints(maxHeight: 90.0),
                  child: const Text(
                    "Recent:",
                    textAlign: TextAlign.right,
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.sizeOf(context).width * 0.05,
                      vertical: 8.0),
                  //Shows all the recipes in a gridview
                  child: GridB(fetchFunction: Api().fetchRecipes),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Navbar that adjust to the size
  AppBar navBar(bool isLargeScreen, BuildContext context) {
    return AppBar(
        backgroundColor: primary,
        elevation: 0,
        titleSpacing: 0,
        leading: isLargeScreen
            ? null
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Recipe Organizer",
                style:
                    TextStyle(color: secondary, fontWeight: FontWeight.bold),
              ),
              if (isLargeScreen) Expanded(child: _navBarItems(context))
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: loggedIn ? const CircleAvatar(child: ProfileIcon()) : null,
          )
        ],
      );
  }
}

//The items for the navbar
final List<String> _menuItems = <String>[
  'Meal Plan',
  'Shopping List',
];

//Drawer that appears when the screen gets to small
Widget _drawer(BuildContext context) => Drawer(
      child: ListView(
        children: _menuItems
            .map((item) => ListTile(
                  onTap: () {
                    _handleDrawerItemClick(context, item);
                  },
                  title: Text(item),
                ))
            .toList(),
      ),
    );

//items from the navbar and the navigation to the right screen
Widget _navBarItems(BuildContext context) {
  List<String> filteredMenuItems = loggedIn
      ? _menuItems.where((item) => item != "Login").toList()
      : _menuItems;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // The mapping for the Navbar items
      ...filteredMenuItems.map(
        (item) => InkWell(
          onTap: () {
            _handleNavbarItemClick(context, item);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
            child: Text(
              item,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    ],
  );
}

//Handles the navigation for the drawer and the navbar
void _handleNavbarItemClick(BuildContext context, String item) {
  if (item == "Shopping List") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ShoppingListScreen(),
      ),
    );
  } else if (item == "Meal Plan") {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MealPlanningScreen(),
      ),
    );
  }
}

void _handleDrawerItemClick(BuildContext context, String item) {
  Navigator.pop(context); // Close the drawer after selecting an item
  _handleNavbarItemClick(context, item); // Reuse the same logic as the navbar
}



//The profile icon and the dropdown to navigate to ther user screens
enum Menu { itemOne, itemTwo, itemThree }

class ProfileIcon extends StatefulWidget {
  const ProfileIcon({super.key});

  @override
  ProfileIconState createState() => ProfileIconState();
}

class ProfileIconState extends State<ProfileIcon> {
  final UserStorage _userStorage = UserStorage();
  final FavoritedRecipesStorage _favoritedRecipesStorage = FavoritedRecipesStorage();
  int ownRecipes = 0;
  int? likedRecipes;
  String? username;

  @override
  void initState() {
    super.initState();
    Api().fetchUserRecipes().then((recipes) {
      setState(() {
        ownRecipes = recipes.length;
      });
    });
    _userStorage.getUserName().then((value) => username = value);
  }


  @override
  Widget build(BuildContext context) {
    if(loggedIn) {
      _userStorage.saveTotalCreatedRecipes(ownRecipes);
    }
    return PopupMenuButton<Menu>(
            offset: const Offset(0, 40),
        onSelected: (Menu item) async {
            int likedRecipes = (await _favoritedRecipesStorage.getFavoritedRecipes()).length;
            navigateToScreen(item, context, likedRecipes);
          },
        icon: const Icon(Icons.person),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                  const PopupMenuItem<Menu>(
                    value: Menu.itemOne,
                    child: Text('Profile'),

                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemTwo,
                    child: Text('Liked Recipes'),
                  ),
                  const PopupMenuItem<Menu>(
                    value: Menu.itemThree,
                    child: Text('Sign Out'),
                  ),
                ]);
  }

  void navigateToScreen(Menu item, BuildContext context, int likedRecipes) {
    if (item == Menu.itemOne) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfilePage(
            userProfile: UserProfile(
              name: username ?? '',
              profileImage: 'assets/user_icon.png',
              likedRecipes: likedRecipes,
              createdRecipes: ownRecipes,
            ),
          ),
        ),
      );
    } else if (item == Menu.itemTwo) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LikedRecipesPage(
            profile: Profile(
              name: username ?? '',
              profileImage: 'assets/user_icon.png',
              likedRecipes: likedRecipes,
            ),
          ),
        ),
      );
    } else if (item == Menu.itemThree) {
      Api().signout(context);
    }
  }
}