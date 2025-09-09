import 'package:flutter/material.dart';

void main() {
  runApp(AppWidget(title: 'OLA MUNDOOO22333222'));
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
