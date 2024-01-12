import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/android/navbar_android.dart';
import '../utils/api.dart';
import 'registration_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.title});

  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                    key: const Key('loginButton'),
                    onPressed: () {
                      login(
                        usernameController.text,
                        passwordController.text,
                        context,
                      );
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                child: Center(
                  child: TextButton(
                    key: const Key('registrationButton'),
                    onPressed: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Registration()));
                    },
                    child: const Text('Sign up!'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
