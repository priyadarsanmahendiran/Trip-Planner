import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Row(
            children: [
              Text("userName")
            ],
          ),
          Row(
            children: [
              Text("Settings")
            ],)
        ],
      ),
    );
  }
  
}