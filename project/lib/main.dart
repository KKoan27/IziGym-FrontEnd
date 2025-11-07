import 'package:flutter/material.dart';
import 'package:project/pages/login.dart';

void main() {
  IziGymLoginApp loginscreen = IziGymLoginApp();
  runApp(loginscreen);
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
