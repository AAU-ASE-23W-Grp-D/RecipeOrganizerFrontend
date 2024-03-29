import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:recipe_organizer_frontend/colors.dart";
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/shopping_list_storage.dart';

// Create an instance of SecureStorageShoppingList
SecureStorageShoppingList _slStorage = SecureStorageShoppingList();

class RecipeDetailScreenWeb extends StatefulWidget {
  final Image image = Image.asset("assets/test_resources/image.png");
  final String name = "Cheeseburger";
  final String username = "Moser";
  final Image userimage = Image.asset("assets/user_icon.png");
  final Recipe recipe;

  RecipeDetailScreenWeb({super.key, required this.recipe});

  @override
  State<RecipeDetailScreenWeb> createState() => _DetailspageState();
}

class _DetailspageState extends State<RecipeDetailScreenWeb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe: ${widget.recipe.name}"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 30.0,
            horizontal: MediaQuery.of(context).size.width * 0.1),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            constraints: const BoxConstraints(maxHeight: 90.0),
                            child: Text(
                              widget.recipe.name,
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          CreatorRecipe(widget: widget),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (screenWidth > 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 2, child: IngridientColumn(widget: widget)),
                    Expanded(
                        flex: 2,
                        child: DescriptionColumn(
                          widget: widget,
                        )),
                    Expanded(flex: 1, child: ImageColumn(widget: widget)),
                  ],
                ),
              if (screenWidth <= 600)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ImageColumn(widget: widget),
                    IngridientColumn(widget: widget),
                    DescriptionColumn(widget: widget),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Column that displays the image of the recipe
class ImageColumn extends StatelessWidget {
  const ImageColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const Key("imageColumn"),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Image.memory(
              widget.recipe.image,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

// Column that displays the recipe description
class DescriptionColumn extends StatelessWidget {
  const DescriptionColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Column(key: const Key("descriptionColumn"), children: [
      const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Description", style: TextStyle(fontSize: 16))),
      Text(
        widget.recipe.description,
        style: const TextStyle(color: inActiveColor),
      ),
      const SizedBox(
        height: 40,
      )
    ]);
  }
}

// Column that displays the ingredients of the recipe
class IngridientColumn extends StatelessWidget {
  const IngridientColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;
// Function to parse the formatted ingredients and create a list of Ingridientitem
  List<Ingridientitem> parseIngredients(String formattedIngredients) {
    List<String> ingredientsList = formattedIngredients.split(',');

    return ingredientsList.map((ingredient) {
      List<String> parts = ingredient.split('*');
      return Ingridientitem(name: parts[1], measurement: parts[0]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Ingridientitem> ingredientItems =
        parseIngredients(widget.recipe.ingredients);

    return Column(
      key: const Key("ingridientList"),
      children: [
        const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Ingredients", style: TextStyle(fontSize: 16)),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: DottedBorder(
            borderType: BorderType.Rect,
            strokeWidth: 0.8,
            dashPattern: const [1],
            color: inActiveColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ingredientItems,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: null,
                    child: Text("Add to Shopping List"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Class representing an ingredient item
class Ingridientitem extends StatelessWidget {
  final String name;
  final String measurement;

  const Ingridientitem({super.key, this.name = "", this.measurement = ""});

  void _insertShoppingList(String name, String quantity) async {
    await _slStorage.insertShoppingListItem2(name, quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: const Key("Ingridientitem"),
      children: [
        const Icon(
          Icons.trip_origin,
          color: primary,
          size: 20,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          key: const Key("ing_name"),
          name,
          style: const TextStyle(color: inActiveColor),
        ),
        const Text(": "),
        Text(key: const Key("ing_measurement"), measurement),
        const Spacer(),
        IconButton(
            onPressed: () {
              _insertShoppingList(name, measurement);
            },
            icon: const Icon(CupertinoIcons.add))
      ],
    );
  }
}

// Column that displays information about the recipe creator
class CreatorRecipe extends StatelessWidget {
  const CreatorRecipe({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key("RecipeCreator"),
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: labelColor, width: 0.1)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  key: Key("profilePicture"),
                  radius: 20,
                  backgroundImage: AssetImage(("assets/user_icon.png")),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.username,
                        style: const TextStyle(fontSize: 14, color: textColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              key: const Key("rating"),
              padding: const EdgeInsets.only(top: 8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      for (int i = 1; i <= 5; i++)
                        Icon(
                          Icons.star,
                          color: i <= widget.recipe.rating
                              ? primary
                              : Colors.grey.withOpacity(0.6),
                          size: 15,
                        ),
                    ],
                  ),
                  Text(
                    "Ratings: ${widget.recipe.rating_amount}",
                    style: const TextStyle(fontSize: 12, color: textColor),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
