import 'package:flutter/material.dart';
import '../utils/api.dart';

class Registration extends StatefulWidget {
  HomeState createState() => HomeState();
}

class HomeState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                key: const Key('usernameField'),
                controller: usernameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Username"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                key: const Key('emailField'),
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                key: const Key('passwordField'),
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Password"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  key: const Key('registerButton'),
                  onPressed: () {
                    register(
                      usernameController.text,
                      emailController.text,
                      passwordController.text,
                      context,
                    );
                  },
                  child: const Text('Register'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
