import 'package:flutter/material.dart';
import 'pages/login.dart'; // Importa a tela de login para ser a primeira a aparecer
import 'package:project/pages/AdicionaExercicio.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/MontagemTreino.dart';

// A função main() é onde tudo começa. O Flutter busca essa função para iniciar o app.
void main() {
  runApp(
    MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark, // Define que o app é escuro (Dark Mode)
        scaffoldBackgroundColor: Colors.black, // Fundo padrão das telas
        primarySwatch:
            Colors.red, // Cor primária (usada em alguns componentes nativos)
        // O ColorScheme é a forma moderna de definir cores principais
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50000), // Vermelho padrão do seu app
          secondary: Color(0xFFE50000),
          surface: Color(0xFF1C1C1C), // Cor de cartões e superfícies
        ),

        // Define o estilo padrão de todos os Inputs (Caixas de Texto)
        inputDecorationTheme: InputDecorationTheme(
          filled: true, // Diz que o campo tem uma cor de fundo
          fillColor: const Color(0xFF1C1C1C), // Cor de fundo cinza escuro
          // Borda quando o campo está normal
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 2.0),
          ),
          // Borda quando o usuário clica para digitar (Focado)
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 3.0),
          ),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),

      // Define qual é a primeira tela que o usuário vê
      home: const LoginScreen(),
    );
  }
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
