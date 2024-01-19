import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/screens/shopping_list_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper().open;
  runApp(const MyApp());
}




