import 'package:flutter/material.dart';
import 'package:trip_planner/nav_bar.dart';
import 'package:trip_planner/profile.dart';

class HomeScreen extends StatefulWidget {

  final String title;
  
  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  int _currentIndex = 0;

	void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

	final List<Widget> _pages = [
    const Profile(),
    const Center(child: Text('Profile Page', style: TextStyle(fontSize: 24))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
      ),
      body: const Column(
        children: [
          SizedBox.expand(
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  Text(
                    "Your Upcoming Trips",
                    style: TextStyle(
                      fontFamily: 'Bogle',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text("Trip1"),
                  Text("Trip2"),
                  Text("Trip3"),
                ],
              ),
            ),
          ),
          SizedBox.expand(
            child: Card(
              margin: EdgeInsets.zero,
              child: Column(
                children: [
                  Text(
                    "Your Previous Expenses",
                    style: TextStyle(
                      fontFamily: 'Bogle',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavBar(currentIndex: _currentIndex, onTabSelected: _onTabSelected,),
    );
  }
}
