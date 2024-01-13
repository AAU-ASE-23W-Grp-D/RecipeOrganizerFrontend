import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/colors.dart';
//import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/screens/android/home_screen_android.dart';
import 'package:recipe_organizer_frontend/screens/navbar_web.dart';
import 'package:recipe_organizer_frontend/screens/android/recipe_detail_screen_android.dart';
import 'package:recipe_organizer_frontend/screens/home_page.dart';

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
          backgroundColor: primary, // Set your app bar background color
          elevation: 0, // Remove shadow
        ),
      ),
      
     
      home: kIsWeb ? ResponsiveNavBarPage() : MyHomePageApp(),
      //home: MyHomePageWeb(),
      /*home: Detailspage(
        image:"https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", 
        name: "Cheeseburger", 
        username: "Moser",
        userimage: "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"),
    */
    
    );
  }
}


