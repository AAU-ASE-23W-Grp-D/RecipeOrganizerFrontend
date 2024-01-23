import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/api.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';
import 'package:recipe_organizer_frontend/widgets/footer.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';
import 'package:recipe_organizer_frontend/screens/login_screen.dart';
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
        appBar: AppBar(
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
                  style: TextStyle(
                      color: secondary, fontWeight: FontWeight.bold),
                ),
                if (isLargeScreen) Expanded(child: _navBarItems(context))
              ],
            ),
          ),
          actions:  [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: loggedIn ? const CircleAvatar(child: _ProfileIcon()):null,
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: [
                   Container(
                    constraints: const BoxConstraints(maxHeight: 90.0),
                     child: const Text(
                      "Recent:",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,

                      ),

                      ),
                   ),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal:MediaQuery.sizeOf(context).width*0.05, vertical: 8.0),
                     child: GridB(fetchFunction: Api().fetchRecipes),
                   ),
             ],
           ),
         ),
       ),
        ),
    );
  }

  Widget _drawer() => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );
}

Widget _navBarItems(BuildContext context) {
  List<String> filteredMenuItems = loggedIn ? _menuItems.where((item) => item != "Login").toList() : _menuItems;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // The mapping for the Navbar items
      ...filteredMenuItems.map(
        (item) => InkWell(
          onTap: () {
            if (item == "Login") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(title: 'Recipe Organizer: Login Page'),
                ),
              );
            }
            if (item == "Shopping List") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ShoppingListScreen(),
                ),
              );
            }
            if (item == "Meal Plan") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealPlanningScreen(),
                ),
              );
            }
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

final List<String> _menuItems = <String>[
  'Meal Plan',
  'Shopping List',
  'Login',
];


enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatefulWidget {
  const _ProfileIcon();

  @override
  _ProfileIconState createState() => _ProfileIconState();
}

class _ProfileIconState extends State<_ProfileIcon> {
  final UserStorage _userStorage = UserStorage();
  int ownRecipes = 0;

  @override
  void initState() {
    super.initState();
    Api().fetchUserRecipes().then((recipes) {
      setState(() {
        ownRecipes = recipes.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String? username;

    if(loggedIn) {
      _userStorage.getUserName().then((value) => username = value);
      _userStorage.saveTotalCreatedRecipes(ownRecipes);
    }

    return PopupMenuButton<Menu>(
        icon: const Icon(Icons.person),
        offset: const Offset(0, 40),
        onSelected: (Menu item) {
          if (item == Menu.itemOne) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfilePage(
        userProfile: UserProfile(
          name: username ?? '',
          profileImage: 'assets/user_icon.png',
          likedRecipes: 50,
          createdRecipes:  ownRecipes,
        ),
                      ),
                      ),
                    );
                  }
          else if (item == Menu.itemTwo) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LikedRecipesPage(
                  profile: Profile(
                    name: 'John Doe',
                    profileImage: 'assets/user_icon.png',
                    likedRecipes: 50
                  ),
                ),
              ),
            );
          }
          else if (item == Menu.itemThree) {
            Api().signout(context);
          }

        },
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
}