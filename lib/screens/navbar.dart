import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive NavBar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white, // Set your app bar background color
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
              title: const Text('Your App'),
              actions: [
                MediaQuery.of(context).size.width > 600
                    ? const DesktopNavbar()
                    : const MobileNavbar(),
              ],
            );
          },
        ),
      ),
      body: const Center(
        child: Text('Your Content Here'),
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
        NavItem(title: 'About'),
        NavItem(title: 'Services'),
        NavItem(title: 'Contact'),
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
        PopupMenuItem(
          child: NavItem(title: 'Home'),
        ),
        PopupMenuItem(
          child: NavItem(title: 'About'),
        ),
        PopupMenuItem(
          child: NavItem(title: 'Services'),
        ),
        PopupMenuItem(
          child: NavItem(title: 'Contact'),
        ),
      ],
    );
  }
}

class NavItem extends StatelessWidget {
  final String title;

  NavItem({required this.title});

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
