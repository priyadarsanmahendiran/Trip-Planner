import 'package:flutter/material.dart';

class NavBar extends StatefulWidget {

  final Function(int) onTabSelected;
  final int currentIndex;
  
  const NavBar({super.key, required this.currentIndex, required this.onTabSelected});

  @override
  State<NavBar> createState() => _NavBarState();
  
}

class _NavBarState extends State<NavBar> {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: widget.onTabSelected,
        fixedColor: Colors.blueAccent,
        currentIndex: widget.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trip_origin),
            label: 'Trips',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.verified_user),
            label: 'Profile',
          ),
        ],
      );
  }
  
}