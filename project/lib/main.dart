import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

void main() {
<<<<<<< HEAD
  runApp(MaterialApp(home: MontagemTreino()));
=======

IziGymLoginApp loginscreen = IziGymLoginApp();
  runApp(loginscreen);
>>>>>>> 26121a6bfd5eaf49a1d1dd3733a463741fb460dc
}

class MontagemTreino extends StatefulWidget {
  @override
  State<MontagemTreino> createState() {
    return MontagemTreinoState();
  }
}

class MontagemTreinoState extends State<MontagemTreino> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(child: Text("Ola mundo")),
            Container(child: Text("Ola mundo2")),
            Container(child: Text("Ola mundo3")),
          ],
        ),
      ),
    );
  }
}
