import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../login_page.dart';
import '../../colors.dart';

class NavBarScreen extends StatelessWidget {
  const NavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
        Container(
          color: primary,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: GNav(
              backgroundColor: primary,
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
                    );
                }
                if(index == 0){
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
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
        );
  }
}