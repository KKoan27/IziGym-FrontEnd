import 'package:flutter/material.dart';
import 'package:project/pages/MontagemTreino.dart';
import 'package:project/pages/treinoPage.dart';
import 'package:project/pages/lista_exercicios_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int locale = 0; // Alterei para 0 para iniciar na lista de exercícios

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: selectItem(locale),
      backgroundColor: const Color.fromARGB(255, 43, 42, 42),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(
          255,
          28,
          28,
          28,
        ), // Fundo mais escuro
        currentIndex: locale,
        selectedItemColor: const Color(0xFFE50000), // Vermelho IziGym
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          locale = value;
        }),
        items: [
          BottomNavigationBarItem(
            // Ícone padrão (Inativo)
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/IconMusculo.png',
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
            ),
            // Ícone Ativo (Com Zoom)
            activeIcon: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/IconMusculo.png',
                width: 24,
                height: 24,
                color: const Color(0xFFE50000),
              ),
            ),
            label: "Exercícios",
          ),
          BottomNavigationBarItem(
            // Ícone padrão (Inativo)
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/IconPrancheta.png',
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
            ),
            // Ícone Ativo (Com Zoom)
            activeIcon: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/IconPrancheta.png',
                width: 24,
                height: 24,
                color: const Color(0xFFE50000),
              ),
            ),
            label: "Treinos",
          ),
          BottomNavigationBarItem(
            // Ícone padrão (Inativo)
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/IconPerfil.png',
                width: 24,
                height: 24,
                color: Colors.grey,
              ),
            ),
            // Ícone Ativo (Com Zoom)
            activeIcon: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                'assets/IconPerfil.png',
                width: 24,
                height: 24,
                color: const Color(0xFFE50000),
              ),
            ),
            label: "Perfil",
          ),
        ],
      ),
    );
  }

  Widget selectItem(int index) {
    switch (index) {
      case 0:
        return const ListaExerciciosPage(); // Página de Exercícios
      case 1:
        return const TreinoPage(); // Página de Treinos
      case 2:
        return const Center(
          child: Text(
            "Perfil",
            style: TextStyle(color: Colors.white),
          ), // Página de Perfil
        );
      default:
        return const Center(
          child: Text("Erro", style: TextStyle(color: Colors.white)), // Erro
        );
    }
  }
}
