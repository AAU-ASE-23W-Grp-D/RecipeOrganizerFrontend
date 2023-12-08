import 'package:flutter/material.dart';
import 'package:adaptive_navbar/adaptive_navbar.dart';
import 'login_page.dart';

class MyHomePageWeb extends StatefulWidget{
  const MyHomePageWeb({Key? key}): super(key: key);

  @override
  State<MyHomePageWeb> createState() => _MyHomePageWebState();
}

class _MyHomePageWebState extends State<MyHomePageWeb> {

  @override
  Widget build(BuildContext context) {
    /// Screen Width of the device.
    final sw = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AdaptiveNavBar(
        screenWidth: sw,
        title: const Text("Recipe Organizer"),
        navBarItems: [
          NavBarItem(
            text: "Home",
            onTap: () {
              Navigator.pushNamed(context, "routeName");
            },
          ),
          NavBarItem(
            text: "Meal Plan",
            onTap: () {
              Navigator.pushNamed(context, "routeName");
            },
          ),
          NavBarItem(
            text: "Shopping List",
            onTap: () {
              Navigator.pushNamed(context, "routeName");
            },
          ),
          NavBarItem(
            text: "Login",
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Recipe Organizer: Login Page')
                    ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'No Recipes available',
        ),
      ),
    );
  }
}

/*class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Builder(
          builder: (BuildContext context) {
            return AppBar(
              title: const Text('Recipe Organizer'),
              actions: [
                  MediaQuery.of(context).size.width > 600 
                    ?  const DesktopNavbar()
                    :  const MobileNavbar(),                
              ],
            );
          },
        ),
      ),
      body:  const Center(
        child: Text('No Recipes available yet'),
      ),
      
    );
  }
}

class DesktopNavbar extends StatelessWidget {
  const DesktopNavbar({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const NavItem(title: 'Home'),
        const NavItem(title: 'Recipes'),
        const NavItem(title: 'Search'),
        NavItem(title: 'Login', onPressed: () {
            Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Recipe Organizer: Login Page')
                    ),
          );
          },
          ),
      ],
    );
  }
}


class MobileNavbar extends StatelessWidget {
  const MobileNavbar ({super.key});
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.menu),
      itemBuilder: (BuildContext context) => [
         const PopupMenuItem(
          child: NavItem(title: 'Home'),
        ),
         const PopupMenuItem(
          child: NavItem(title: 'Recipes'),
        ),
         const PopupMenuItem(
          child: NavItem(title: 'Search'),
        ),
         const PopupMenuItem(
          child: NavItem(title: 'Login'),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  const NavItem({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {
          // Handle navigation or action when the item is tapped
        },
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.black, // Set your text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
*/


