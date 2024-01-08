import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:recipe_organizer_frontend/colors.dart';
import 'package:recipe_organizer_frontend/screens/android/recipe_detail_screen_android.dart';
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
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },{
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
    },
    {
      "name": "Cheeseburger",
      "rating" : "4.5",
      "images" : "https://images.unsplash.com/photo-1586190848861-99aa4a171e90?q=80&w=2080&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
      
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
        int crossAxisCount = (MediaQuery.of(context).size.width ~/ 200).toInt();
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
                          style: Theme.of(context).textTheme.subtitle1!.merge(
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
                                style: Theme.of(context).textTheme.subtitle2!.merge(
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
}