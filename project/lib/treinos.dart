import 'package:flutter/material.dart';

void main() {
  runApp(Container()) {}
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
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Container(alignment: Alignment(10, 15), child: Text("Ola mundo")),
          Container(child: Text("Ola mundo2")),
          Container(child: Text("Ola mundo3")),
        ],
      ),
    );
  }
}
