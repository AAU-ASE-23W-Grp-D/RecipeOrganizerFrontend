import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.2,
      color: Colors.black, // Black background color
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Column 1
          Column(
            children: [
              Text(
                'Home',
                style: TextStyle(
                  color: Colors.white, // White text color
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Meal Plan',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Shopping List',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Column 2
          Column(
            children: [
              Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Liked Recipes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Sign Out',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),

          // Column 3
          Column(
            children: [
              Text(
                'Recipes',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Create Recipe',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'My Recipes',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
