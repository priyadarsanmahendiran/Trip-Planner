import 'package:flutter/material.dart';
import 'package:trip_planner/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
	WidgetsFlutterBinding.ensureInitialized();
	await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
	);
	runApp(const TripPlanner());
}

class TripPlanner extends StatelessWidget {
	const TripPlanner({super.key});

	// This widget is the root of your application.
	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			title: 'Plannit',
			theme: ThemeData(
				fontFamily: 'Bogle',
				colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 21, 113, 188)),
				useMaterial3: true,
			),
			home: const MyHomePage(title: 'Plannit'),
		);
	}
}

class MyHomePage extends StatefulWidget {
	const MyHomePage({super.key, required this.title});

	final String title;

	@override
	State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

	@override
	Widget build(BuildContext context) {
		return const Scaffold(
			body: Home(),
		);
	}
}
