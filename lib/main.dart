import 'package:flutter/material.dart';
//import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/screens/navbar_android.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';

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
          backgroundColor: Color.fromRGBO(121,220,241,1), // Set your app bar background color
          elevation: 0, // Remove shadow
        ),
      ),
      //home: kIsWeb ? MyHomePageWeb() : MyHomePageApp(),
      home: Detailspage(
        image:"https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
        name: "Cheeseburger", 
        username: "Moser",
        userimage: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    );
  }
}
