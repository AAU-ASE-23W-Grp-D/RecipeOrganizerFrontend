import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/widgets/footer.dart';
import 'package:recipe_organizer_frontend/widgets/gridview.dart';
import 'package:recipe_organizer_frontend/screens/login_screen.dart';
import 'package:recipe_organizer_frontend/screens/meal_plan_screen.dart';
import 'package:recipe_organizer_frontend/screens/profile_screen.dart';
import 'package:recipe_organizer_frontend/screens/liked_recipes_screen.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_screen.dart';

bool logged_in = true;

class ResponsiveNavBarPage extends StatelessWidget {
  ResponsiveNavBarPage({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: Footer(),
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
              padding: EdgeInsets.only(right: 16.0),
              child: logged_in ? CircleAvatar(child: _ProfileIcon()):null,
            )
          ],
        ),
        drawer: isLargeScreen ? null : _drawer(),
        body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: [
                   Container(
                    constraints: BoxConstraints(maxHeight: 90.0),
                     child: Text(
                      "Recent:",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,

                      ),

                      ),
                     /*Padding(
                       padding: EdgeInsets.all(8.0),
                       child: SearchBarApp(),
                     ),*/
                   ),
                   //SizedBox(height: 1000,),
                   Padding(
                     padding: EdgeInsets.symmetric(horizontal:MediaQuery.sizeOf(context).width*0.05, vertical: 8.0),
                     child: GridB(),
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
  List<String> filteredMenuItems = logged_in ? _menuItems.where((item) => item != "Login").toList() : _menuItems;
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      // Your search bar widget
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: SizedBox(
          width: 200, // Adjust the width as needed
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
            ),
            onChanged: (searchQuery) {
              // Handle search query changes
            },
          ),
        ),
      ),

      // Spacer to separate the search bar from menu items
      SizedBox(width: 16),

      // Your menu items
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
                  builder: (context) => ShoppingListScreen(),
                ),
              );
            }
            if (item == "Meal Plan") {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MealPlanningScreen(),
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
  'Home',
  'Meal Plan',
  'Shopping List',
  'Login',
];


enum Menu { itemOne, itemTwo, itemThree }

class _ProfileIcon extends StatelessWidget {
  const _ProfileIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          name: 'John Doe',
          profileImage: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          likedRecipes: 50,
          createdRecipes: 10,
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
                    profileImage: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    likedRecipes: 50
                  ),
                ),
              ),
            );
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