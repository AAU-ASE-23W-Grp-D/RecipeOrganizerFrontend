import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Organizer: Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(121,220,241,0), // Set your app bar background color
          elevation: 0, // Remove shadow
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
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
        NavItem(title: 'Home'),
        NavItem(title: 'Recipes'),
        NavItem(title: 'Search'),
        NavItem(title: 'Login', onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SecondRoute()),
            );
          },
          ),
      ],
    );
  }
}
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class LoginRoute extends StatelessWidget {
  const LoginRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Organizer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(title: 'Recipe Organizer'),
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
         PopupMenuItem(
          child: NavItem(title: 'Home'),
        ),
         PopupMenuItem(
          child: NavItem(title: 'Recipes'),
        ),
         PopupMenuItem(
          child: NavItem(title: 'Search'),
        ),
         PopupMenuItem(
          child: NavItem(title: 'Login'),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;

  NavItem({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: TextButton(
        onPressed: () {
          // Handle navigation or action when the item is tapped
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black, // Set your text color
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}



