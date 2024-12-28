import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/nav_bar.dart';
import 'package:trip_planner/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {

  final String title;
  
  const HomeScreen({super.key, required this.title});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  int _currentIndex = 0;
  List<Map<String, dynamic>> fetchedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

	void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where(FieldPath.documentId, isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

      // Extract the data from documents
      List<Map<String, dynamic>> data = snapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      setState(() {
        fetchedData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Ensure the Card wraps its content
              children: [
                const Text(
                  "Your Upcoming Trips",
                  style: TextStyle(
                    fontFamily: 'Bogle',
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SizedBox(
                        height: 200, // Provide a fixed height
                        child: ListView.builder(
                          itemCount: fetchedData.length,
                          itemBuilder: (context, index) {
                            final item = fetchedData[index];
                            return ListTile(
                              title: Text(item['destination'] ?? '--'),
                              subtitle: Text(item['description'] ?? '--'),
                            );
                          },
                        ),
                      ),
              ],
            ),
          ),
          const Card(
            margin: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure the Card wraps its content
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
        ],
      ),
      bottomNavigationBar: NavBar(
        currentIndex: _currentIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
