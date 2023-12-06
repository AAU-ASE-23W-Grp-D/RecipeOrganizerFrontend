import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_page.dart';

class MyHomePage extends StatefulWidget{
  const MyHomePage({Key? key}): super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: Container(
        color: Color.fromRGBO(121,220,241,1),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GNav(
            backgroundColor: Color.fromRGBO(121,220,241,1),
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            padding: EdgeInsets.all(16),
            onTabChange: (index){
              if(index == 3){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(title: 'Recipe Organizer')
                    ),
          );}
            },
          
            gap: 8,
            tabs: [
              GButton(icon: Icons.home, text: 'Home',),
              GButton(icon: Icons.favorite, text: 'Liked Recipes'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.person, text: 'Profile')
              ],
          ),
        ),
      ),
    );
  }
}