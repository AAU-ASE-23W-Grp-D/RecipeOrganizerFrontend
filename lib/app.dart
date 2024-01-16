import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'screens/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load configuration from assets at app start
    GlobalConfiguration().loadFromAsset("app_settings");

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


