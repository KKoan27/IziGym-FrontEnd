import 'package:flutter/material.dart';
import 'package:project/pages/AdicionaExercicio.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/MontagemTreino.dart';

void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red[900]!),
      ),
      routes: {
        // '/loginpage': (context) => LoginPage,
        '/homepage': (context) => HomePage(),
        '/addtreino': (context) => MontagemTreino(),
        '/selectexercicio': (context) => AdicionaExercicio(),
      },
      initialRoute: '/homepage',
      debugShowCheckedModeBanner: false,
    ),
  );
}
