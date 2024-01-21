import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "package:recipe_organizer_frontend/colors.dart";
import 'package:recipe_organizer_frontend/models/recipe.dart';
import 'package:recipe_organizer_frontend/utils/shopping_list_storage.dart';
import 'package:recipe_organizer_frontend/utils/user_storage.dart';

SecureStorageShoppingList _SlStorage = SecureStorageShoppingList();

class RecipeDetailScreenWeb extends StatefulWidget {
  final String image = "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  final String name = "Cheeseburger";
  final String username = "Moser";
  final String userimage = "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
  final Recipe recipe;

  const RecipeDetailScreenWeb({super.key, required this.recipe});


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
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: MediaQuery.of(context).size.width * 0.1),
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
                            constraints: BoxConstraints(maxHeight: 90.0),
                            child: Text(
                              widget.recipe.name,
                              textAlign: TextAlign.right,
                              style: TextStyle(
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
                    Expanded(flex: 2, child: DescriptionColumn(widget: widget,)),
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



class ImageColumn extends StatelessWidget {
  const ImageColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: Key("imageColumn"),
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

class DescriptionColumn extends StatelessWidget {
  const DescriptionColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key("descriptionColumn"),
      children:[
      const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text("Description",style: TextStyle(fontSize: 16))),
        Text(widget.recipe.description,
        style: const TextStyle(color: inActiveColor),
        ),
        const SizedBox(height: 40,)]
              
    );
  }
}

class IngridientColumn extends StatelessWidget {
  const IngridientColumn({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  List<Ingridientitem> parseIngredients(String formattedIngredients) {
    List<String> ingredientsList = formattedIngredients.split(',');

    return ingredientsList.map((ingredient) {
      List<String> parts = ingredient.split('*');
      return Ingridientitem(name: parts[1], measurement: parts[0]);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<Ingridientitem> ingredientItems = parseIngredients(widget.recipe.ingredients);

    return Column(
      key: Key("ingridientList"),
      children: [
        Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text("Ingredients",style: TextStyle(fontSize: 16),),
                  ),
        Padding(
                    padding: EdgeInsets.only(right:8.0),
                    child: DottedBorder(
                      borderType: BorderType.Rect,
                      strokeWidth: 0.8,
                      dashPattern: const [1,],
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
                              child: Text("Add to Shopping List"))
                          ),
                        ],
                      ) ),
                  ),
      ]
    );
  }
}

class Ingridientitem extends StatelessWidget {
  final String name;
  final String measurement;


   const Ingridientitem({
    super.key,
    this.name = "",
    this.measurement = ""
  });

  void _insertShoppingList(String name, String quantity) async {
    await _SlStorage.insertShoppingListItem2(name,quantity);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key("Ingridientitem"),
      children: [
        Icon(Icons.trip_origin, color: primary, size: 20,),
        SizedBox(width: 4,),
        Text(this.name,style: TextStyle(color: inActiveColor),),
        Text(": "),
        Text(this.measurement),
        Spacer(),
        IconButton(onPressed: () {
          _insertShoppingList(name, measurement);
        }, icon: Icon(CupertinoIcons.add))
      ],
    );
  }
}

class CreatorRecipe extends StatelessWidget {
  const CreatorRecipe({
    super.key,
    required this.widget,
  });

  final RecipeDetailScreenWeb widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key("RecipeCreator"),
      height:60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
         border: Border.all(color:labelColor,width: 0.1 )
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Row(
              children: [
                 CircleAvatar(
                  key: const Key("profilePicture"),
                  radius: 20,
                  backgroundImage: NetworkImage(widget.userimage),
                ),
                Padding(
                  padding: const EdgeInsets.only(left:8.0,top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                      Text(widget.username,style: const TextStyle(fontSize: 14,color: textColor),)
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              key: Key("rating"),
              padding: const EdgeInsets.only(top:8.0),
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
                  Text("169 upvoted",style: TextStyle(fontSize: 12,color: labelColor),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

