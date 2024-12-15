import 'package:flutter/material.dart';


class Trips extends StatelessWidget {
  const Trips({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Column(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.abc,
          size: 80.0,
          color: Colors.white,
        ),
        SizedBox(
          height: 15.0,
        ),
        Text(
          "genderName",
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xFF8D8E98),
          ),
        ),
      ],
    );
  }
}