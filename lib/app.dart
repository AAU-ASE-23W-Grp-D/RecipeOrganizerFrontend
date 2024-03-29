import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/screens/login_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load configuration from assets at app start
    GlobalConfiguration().loadFromAsset("app_settings");

    return MaterialApp(
      title: 'Recipe Organizer: Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: primary, // Set your app bar background color
          elevation: 0, // Remove shadow
        ),
      ),
      home: const LoginPage(title: "Login to Demo")
    );
  }
}


