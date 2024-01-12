import 'package:flutter/material.dart';

class AddRecipePage extends StatelessWidget {
  final String recipeName;

  AddRecipePage({required this.recipeName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Recipe Name: \n$recipeName",
                      style: const TextStyle(fontSize: 18)),
                ),
                Padding(padding: const EdgeInsets.all(20.0),
                  child: _buildImageUploadField(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSeperatorLine(),
            // Add additional UI elements or logic here
          ],
        ),
      ),
    );
  }

  Widget _buildImageUploadField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            "Upload an image of your recipe", style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {},
          child: null,
        ),
      ],
    );
  }

  Widget _buildSeperatorLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}
