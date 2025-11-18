import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

import 'pages/HomePage.dart';

void main() {

IziGymLoginApp loginscreen = IziGymLoginApp();
  runApp(loginscreen);
}

class AppWidget extends StatelessWidget {
  final String title;

  const AppWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Text(
          title,
          textDirection: TextDirection.ltr,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
