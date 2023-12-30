import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/token_storage.dart';
import 'package:recipe_organizer_frontend/screens/recipe_screen.dart';

//TODO: CHANGE IP TO YOUR IP
const String baseUrl = 'http://localhost:8080/api';

Future<void> login(String username, String password, BuildContext context) async {
  final TokenStorage storage = TokenStorage();
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

    Map<String, dynamic> body = json.decode(response.body);
    int userId = body['id'];
    String username = body['username'];
    List<String> roles = List<String>.from(body['roles']);
    String token = body['token'];

    print('User ID: $userId');
    print('Username: $username');
    print('Roles: $roles');
    print('Token: $token');

    // Store JWT token
    await storage.saveToken(token);

    _navigateToNextScreen(context);
  } else {
    // Login failed, handle accordingly (show error message, etc.)
    print('Login failed');
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
