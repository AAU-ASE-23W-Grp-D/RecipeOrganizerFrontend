import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


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

@override
Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        mainAxisExtent: 310,
      ),
      itemCount: gridMap.length,
      itemBuilder: (_, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
            gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black,
              Color.fromRGBO(121,220,241,1),
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
                        ],
                      ),
                    ),
                    
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          color: Colors.pink,
                          icon: const Icon(
                            CupertinoIcons.heart,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          color: Colors.white,
                          icon: const Icon(
                            CupertinoIcons.search,
                          ),
                        ),
                      ],
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
}