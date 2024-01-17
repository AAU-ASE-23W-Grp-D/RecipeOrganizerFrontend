import 'dart:convert';
import 'package:adaptive_navbar/main.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/models/user.dart';
import 'package:recipe_organizer_frontend/screens/home_screen.dart';
import 'package:recipe_organizer_frontend/utils/token_storage.dart';
import 'package:recipe_organizer_frontend/screens/recipe_screen.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';

import '../screens/login_screen.dart';

// Load the BaseUrl from the configuration file
// On error, check if the assets/cfg/app_settings.json file exists
final String baseUrl = GlobalConfiguration().getValue("BaseUrl");

Future<void> login(String username, String password, BuildContext context) async {
  final UserStorage userStorage = UserStorage();
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signin'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Login successful, handle accordingly (navigate to the next screen, etc.)
    print('Login successful');

    final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
    final user = User.fromJson(responseJson);

    // Store user info and JWT token
    await userStorage.saveUser(user);


    _navigateToHomeScreen(context);

  } else {
    // Login failed, handle accordingly (show error message, etc.)
    print('Login failed');
  }
}

Future<void> register(String username, String email, String password, BuildContext context) async {
  // final UserStorage userStorage = UserStorage();
  final response = await http.post(
    Uri.parse('$baseUrl/auth/signup'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'email': email,
      'password': password,
    }),
  );

  print(response.body);
  if (response.statusCode == 200) {
    // Login successful, handle accordingly (navigate to the next screen, etc.)
    print('Registration successful');

    _navigateToLoginScreen(context);
    showAlertDialog(context, "Sign up successful", "You successfully signed up!");
  } else {
    // Login failed, handle accordingly (show error message, etc.)
    print('Registration failed');
  }
}

Future<void> postRecipe(Recipe recipe, BuildContext context) async {
  // final UserStorage userStorage = UserStorage();
  final TokenStorage storage = TokenStorage();
  String jwtToken = await storage.getToken();

  final response = await http.post(
    Uri.parse('$baseUrl/recipes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'JWT_TOKEN': jwtToken,
    },
    body: jsonEncode(<String, String>{
      'name': recipe.name,
      'ingredients': recipe.ingredients,
      'description': recipe.description,
      'rating': recipe.rating.toString(),
      'image': base64.encode(recipe.image),
    }),
  );

  if (response.statusCode == 200) {
    // Login successful, handle accordingly (navigate to the next screen, etc.)
    print('Recipe posted successfuly');

    _navigateToHomeScreen(context);
    showAlertDialog(context, "Recipe posted successfuly", "You successfully posted a recipe!");
  } else {
    // Login failed, handle accordingly (show error message, etc.)
    print('Recipe posting failed');
  }
}


Future<List<Recipe>> fetchRecipes() async {
  final TokenStorage storage = TokenStorage();
  String jwtToken = await storage.getToken();
  final response = await http.get(
    Uri.parse('$baseUrl/recipes'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'JWT_TOKEN': jwtToken,
    },
  );

  if (response.statusCode == 200) {
    final List body = json.decode(response.body);
    return body.map((e) => Recipe.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load recipes');
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RecipeScreen()));
}

void _navigateToHomeScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResponsiveNavBarPage()));
}

void _navigateToLoginScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginPage(title: 'Recipe Organizer',)));
}

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) {
      // dialog is only shown for 4 seconds
      Future.delayed(const Duration(seconds: 4), () {
        Navigator.of(context).pop(); // Close the dialog
      });
      // returns the AlertDialog
      return AlertDialog(
        title: Text(title),
        content: Text(message),
      );
    },
  );
}
