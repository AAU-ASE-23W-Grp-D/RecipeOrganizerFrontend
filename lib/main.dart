import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/utils/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferencesShoppingList().open;
  runApp(const MyApp());
}




