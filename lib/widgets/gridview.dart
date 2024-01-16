import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:recipe_organizer_frontend/screens/recipe_detail_screen.dart';


class GridB extends StatefulWidget {
  const GridB({super.key});

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap =[
    {
      "name": "Spaghetti Bolognese",
      "rating": "4.8",
      "images": "https://source.unsplash.com/400x300/?spaghetti",
    },
    {
      "name": "Sushi Platter",
      "rating": "4.9",
      "images": "https://source.unsplash.com/400x300/?sushi",
    },
    {
      "name": "Caesar Salad",
      "rating": "4.5",
      "images": "https://source.unsplash.com/400x300/?caesar-salad",
    },
    {
      "name": "Pizza Margherita",
      "rating": "4.7",
      "images": "https://source.unsplash.com/400x300/?pizza",
    },
    {
      "name": "Chocolate Cake",
      "rating": "4.6",
      "images": "https://source.unsplash.com/400x300/?chocolate-cake",
    },
    {
      "name": "Chicken Curry",
      "rating": "4.5",
      "images": "https://source.unsplash.com/400x300/?chicken-curry",
    },
    {
      "name": "Vegetarian Stir-Fry",
      "rating": "4.8",
      "images": "https://source.unsplash.com/400x300/?vegetarian-stir-fry",
    },
    {
      "name": "Fruit Smoothie",
      "rating": "4.9",
      "images": "https://source.unsplash.com/400x300/?fruit-smoothie",
    },
    {
      "name": "Grilled Salmon",
      "rating": "4.7",
      "images": "https://source.unsplash.com/400x300/?grilled-salmon",
    },
  ];
  
  bool isFavorite = false;


int calculateCrossAxisCount(double screenWidth) {
    int baseCount = 7; // Adjust this based on your initial design
    int calculatedCount = (screenWidth / 200).round(); // Adjust 200 based on your item width

    return calculatedCount > baseCount ? calculatedCount : baseCount;
  }

  

@override
Widget build(BuildContext context) {
    
    return LayoutBuilder(
      builder: (context,constraints) {
        int crossAxisCount = (MediaQuery.of(context).size.width ~/ 209).toInt();
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: kIsWeb ? crossAxisCount : 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            mainAxisExtent: 270,
          ),
          itemCount: gridMap.length,
          
          itemBuilder: (_, index) {
            return Container(
              constraints: BoxConstraints(maxWidth: 200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  16.0,
                ),
                gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  secondary,
                  primary,
                ],
              ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      topRight: Radius.circular(16.0),
                    ),
                    child: Image.network(
                      "${gridMap.elementAt(index)['images']}",
                      height: 170,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${gridMap.elementAt(index)['name']}",
                          style: Theme.of(context).textTheme.titleMedium!.merge(
                                const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                "${gridMap.elementAt(index)['rating']} ",
                                style: Theme.of(context).textTheme.titleSmall!.merge(
                                      TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.grey.shade500,
                                      ),
                                    ),
                              ),
                              Icon(Icons.star, color: Colors.grey,),
                              IconButton(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                              color: Colors.pink,
                              icon: isFavorite ? const Icon(CupertinoIcons.heart_fill) : const Icon(CupertinoIcons.heart)
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RecipeDetailScreenWeb(),

                                  )
                                );
                              },
                              color: Colors.white,
                              icon: const Icon(
                                
                                CupertinoIcons.search,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                _showDialog(context, "${gridMap.elementAt(index)['name']}");
                              },
                              color: Colors.black,
                              icon: const Icon(
                                CupertinoIcons.add,
                              ),
                            ),
                            
                            ],
                            
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );

    
  }

  Future<void> _showDialog(BuildContext context, String name) async {
    String selectedDay = 'Monday'; // Initial value

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Day'),
          content: Container(
            height: 150,
            child: Column(
              children: [
                Text("I plan to eat " + name + " on:"),
                DropdownButton<String>(
                  value: selectedDay,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedDay = newValue;
                    }
                  },
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle assignment logic here
                    print('Assigned to $selectedDay');
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('Assign'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}