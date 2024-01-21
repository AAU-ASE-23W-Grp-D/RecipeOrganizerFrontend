import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/app.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //SharedPreferencesShoppingList(UserStorage().getId().toString()).open;
  runApp(const MyApp());
}




