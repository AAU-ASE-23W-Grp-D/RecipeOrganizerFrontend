import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'dart:io';

import 'package:recipe_organizer_frontend/utils/api.dart';

class AddRecipePage extends StatefulWidget {
  final String recipeName;

  const AddRecipePage({super.key, required this.recipeName});

  @override
  AddRecipePageState createState() => AddRecipePageState();
}

class AddRecipePageState extends State<AddRecipePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  List<String> ingredients = [];
  XFile? image;
  late Uint8List imageBytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "Recipe Name: \n${widget.recipeName}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                _buildImageUploadField(),
              ],
            ),
            const SizedBox(height: 20),
            _buildSeparatorLine(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _buildIngredientInputField(),
                  ),
                  Expanded(
                    child: _buildDescriptionField(),
                  ),
                ],
              ),
            ),
            _buildSeparatorLine(),

            //Add a "Save Recipe" button here
            ElevatedButton(
              onPressed: () {
                postRecipe(
                    Recipe(
                        name: widget.recipeName,
                        ingredients: _ingredientController.text,
                        description: _descriptionController.text,
                        rating: 5,
                        image: imageBytes),
                context
                );
              },
              child: const Text("Save Recipe"),
            ),

            // Add additional UI elements or logic here
          ],
        ),
      ),
    );
  }


  Widget _buildImageUploadField() {
    // Placeholder function for image upload
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Upload an image of your recipe",
          style: TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            final imagePicker = ImagePicker();
            final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

            if(pickedImage != null) {
              setState(() {
                image = pickedImage;
              });
              imageBytes = await pickedImage.readAsBytes();
            }
          },
          child: const Text("Pick Image"),
        ),
        const SizedBox(height: 10),
        if(image != null)
          kIsWeb
            ? Image.network(image!.path, height: 100) : Image.file(File(image!.path), height: 100),
      ],
    );
  }

  Widget _buildSeparatorLine() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
  }

  Widget _buildDescriptionField() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: TextField(
        controller: _descriptionController,
        maxLines: 20,
        decoration: const InputDecoration(
          hintText: "Recipe Description",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildIngredientInputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ingredients", style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _ingredientController,
                decoration: const InputDecoration(
                  hintText: "Enter an ingredient",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ingredients.add(_ingredientController.text);
                  _ingredientController.clear();
                });
              },
              child: const Text("Add"),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 500, // Adjust the height as needed
          child: ListView(
            shrinkWrap: true,
            children: ingredients
                .asMap()
                .entries
                .map(
                  (entry) => InkWell(
                onTap: () {
                  setState(() {
                    ingredients.removeAt(entry.key);
                  });
                },
                child: SizedBox(
                  height: 30, // Adjust the height as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("- ${entry.value}"),
                      const SizedBox(width: 5),
                      const Icon(Icons.delete, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }

}
