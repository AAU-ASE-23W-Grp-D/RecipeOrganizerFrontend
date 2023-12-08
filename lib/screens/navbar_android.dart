import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'login_page.dart';
import 'search_bar.dart';

class MyHomePageApp extends StatefulWidget{
  const MyHomePageApp({Key? key}): super(key: key);

  @override
  State<MyHomePageApp> createState() => _MyHomePageAppState();
}

class _MyHomePageAppState extends State<MyHomePageApp>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: SearchBarApp(),
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