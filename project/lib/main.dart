import 'package:flutter/material.dart';
import 'package:project/pages/HomePage.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
      ),

      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ),
  );
}
