import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {

  List<Map<String, dynamic>> fetchedData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {

      DateTime todayStart = DateTime.now();
      todayStart = DateTime(todayStart.year, todayStart.month, todayStart.day);
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('trips')
          .where(FieldPath.documentId, isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .where('startDate', isGreaterThan: todayStart)
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


  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Card(
            margin: const EdgeInsets.all(8),
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
                    : fetchedData.isNotEmpty ? SizedBox(
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
                      ) 
                    : const Center(child: Text('No upcoming trips found')),
              ],
            ),
          ),
          const Card(
            margin: EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
      );
  }
}