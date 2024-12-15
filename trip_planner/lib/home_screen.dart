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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Row(
        children: [
      Column(
        children: [
          Expanded(
              child: Text(
            "Your Upcoming Trips",
          )),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Text("Trip1"),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Text("Trip2"),
                )
              ],
            ),
          ),
        ],
      ),
      Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Text("Your Previous expenses") //TODO: Add expense graph
              ],
            )
          )
        ],
      )]
      ),
      bottomNavigationBar: NavBar(currentIndex: _currentIndex, onTabSelected: _onTabSelected,),
    );
  }
}
