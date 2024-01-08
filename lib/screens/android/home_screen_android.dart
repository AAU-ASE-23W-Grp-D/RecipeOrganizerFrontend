import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:recipe_organizer_frontend/screens/android/navbar_android.dart';
import '../login_page.dart';
import '../search_bar.dart';
import '../gridview.dart';
import '../../colors.dart';

class MyHomePageApp extends StatefulWidget{
  const MyHomePageApp({Key? key}): super(key: key);

  @override
  State<MyHomePageApp> createState() => _MyHomePageAppState();
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
      bottomNavigationBar: const NavBarScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primary,
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