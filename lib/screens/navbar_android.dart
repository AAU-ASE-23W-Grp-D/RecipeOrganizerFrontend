import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'search_bar.dart';

class MyHomePageApp extends StatefulWidget{
  const MyHomePageApp({Key? key}): super(key: key);

  @override
  State<MyHomePageApp> createState() => _MyHomePageAppState();
}

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
            color: Colors.black,
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
                    Text(
                      "${gridMap.elementAt(index)['rating']}",
                      style: Theme.of(context).textTheme.subtitle2!.merge(
                            TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey.shade500,
                            ),
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

class _MyHomePageAppState extends State<MyHomePageApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
       body: SafeArea(
         child: SingleChildScrollView(
           child: Column(
             children: [
               
                 
                   Container(
                    constraints: BoxConstraints(maxHeight: 90.0),
                     child: Padding(
                       padding: EdgeInsets.all(8.0),
                       child: SearchBarApp(),
                     ),
                   ),
                   //SizedBox(height: 1000,),
                 
               
               
                 
                   Padding(
                     padding: EdgeInsets.all(8.0),
                     child: GridB(),
                   ),
                 
               
             ],
           ),
         ),
       ),
      bottomNavigationBar: Container(
        color: const Color.fromRGBO(121,220,241,1),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GNav(
            backgroundColor: const Color.fromRGBO(121,220,241,1),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: const EdgeInsets.all(16),
            onTabChange: (index){
              if(index == 3){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Recipe Organizer: Login Page')
                    ),
          );}
            },
          
            gap: 8,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home',),
              GButton(icon: Icons.favorite, text: 'Liked Recipes'),
              GButton(icon: Icons.schedule, text: 'Meal Plan'),
              GButton(icon: Icons.person, text: 'Profile')
              ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color.fromRGBO(121,220,241,1),
        child: const Icon(Icons.add),
      
      ),
      appBar: AppBar(
        title: const Text("Recipe Organizer"),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 24.0),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search),
            color: Colors.white,)
        ],
        ),
       
    );
  }
}