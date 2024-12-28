import 'package:flutter/material.dart';
import 'package:trip_planner/home.dart';
import 'package:trip_planner/nav_bar.dart';
import 'package:trip_planner/profile.dart';
import 'package:trip_planner/summary.dart';
import 'package:trip_planner/trips.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    const Summary(),
    const Trips(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(
              height: 150,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Text('PLAN-IT\nYour Travel Planner', style: TextStyle(color: Colors.white)),
              ),
            ),
            // ListTile(
            //   title: Image.network(FirebaseAuth.instance.currentUser?.photoURL ?? '')
            // ),
            ListTile(
              title: Text(FirebaseAuth.instance.currentUser?.displayName ?? '')
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const Home()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
