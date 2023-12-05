import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/new_screen.dart';

Future<void> login(String username, String password, BuildContext context) async {
  final response = await http.post(
    //TODO: CHANGE IP TO YOUR IP
    Uri.parse('http://192.168.0.11:8080/api/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': username,
      'password': password,
    }),
  );

  if (response.statusCode == 200 && response.body == 'success') {
    // Login successful, handle accordingly (navigate to the next screen, etc.)
    print('Login successful');
    _navigateToNextScreen(context);
  } else {
    // Login failed, handle accordingly (show error message, etc.)
    print('Login failed');
  }
}

void _navigateToNextScreen(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
}
