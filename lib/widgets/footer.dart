import 'package:flutter/material.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

//Footer with the names of the team.
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height*0.1,
      color: Colors.black, // Black background color
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Created by:",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),)
            ],
          ),
          // Column 1
          Column(
            children: [
              Text(
                'Sandro Moser',
                style: TextStyle(
                  color: Colors.white, 
                ),
              ),
              Text(
                'Mario Leopold',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Christian Schönberg',
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
                'Merlin Christopher Godot Volkmer',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Stefan Philipp Schellander',
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
