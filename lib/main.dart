import 'package:flutter/material.dart';
//import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/screens/navbar_android.dart';

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
      home: const MyHomePage(),
    );
  }
}
