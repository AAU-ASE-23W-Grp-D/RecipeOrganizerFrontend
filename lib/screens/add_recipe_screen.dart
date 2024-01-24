import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

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
  Uint8List imageBytes = Uint8List(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
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
              Row( // Removed the Expanded widget here
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
              _buildSeparatorLine(),

            //Add a "Save Recipe" button here
            ElevatedButton(
              onPressed: () async {
                if(ingredients.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please add at least one ingredient"),
                    ),
                  );
                  return;
                } else if(_descriptionController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Please add a description"),
                    ),
                  );
                  return;
                } else if(imageBytes.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please add an image"),
                      ),
                    );
                    return;
                }
                  String formattedIngredients = ingredients //100ml Milk -> 100ml*Milk,...
                      .map((ingredient) {
                    List<String> parts = ingredient.split(' ');
                    return '${parts[0]}*${parts.sublist(1).join(' ')}';
                  })
                      .join(',');
                  await Api().postRecipe(
                      Recipe(
                          ID: 0,
                          name: widget.recipeName,
                          ingredients: formattedIngredients,
                          description: _descriptionController.text,
                          rating: 5,
                          rating_amount: 1,
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
            if(widget.recipeName == "Test Recipe 101") {
              //load png from assets/test_resources/image.png as XFile
              print("######### Reading in test image");
              imageBytes = (await rootBundle.load('test_resources/image.png')).buffer.asUint8List();
            } else {
              final imagePicker = ImagePicker();
              final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);

              if(pickedImage != null) {
                setState(() {
                  image = pickedImage;
                });
                imageBytes = await pickedImage.readAsBytes();
              }
            }
          },
          key: const Key('uploadImageButton'),
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
        key: const Key('descriptionTextField'),
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
                key: const Key('ingredientTextField'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(_isValidIngredientFormat(_ingredientController.text)){
                  setState(() {
                    ingredients.add(_ingredientController.text);
                    _ingredientController.clear();
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid ingredient format. It should be like: \"100ml Milk\" or \"1 Egg\""),
                    ),
                  );
                }
              },
              key: const Key('addIngredientButton'),
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

  bool _isValidIngredientFormat(String ingredient) {
    // Check if the format is like '100ml Ingredient'
    RegExp regex = RegExp(r'^[\w\d.,]+\s[\w\d.,]+$');
    return regex.hasMatch(ingredient);
  }
}
