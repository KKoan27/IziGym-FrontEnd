import 'package:flutter/material.dart';
import 'package:project/models/usuario.dart';
import 'package:project/pages/MontagemTreino.dart';
import 'package:project/pages/treinoPage.dart';
import 'package:project/pages/lista_exercicios_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.user});
  final UserModel user;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variável que guarda qual aba está selecionada (0, 1 ou 2)
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selecionarTela(_indiceAtual),
      backgroundColor: const Color.fromARGB(255, 43, 42, 42),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(
          255,
          28,
          28,
          28,
        ), // Fundo mais escuro
        currentIndex: _indiceAtual,
        selectedItemColor: const Color(0xFFE50000), // Vermelho IziGym
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          _indiceAtual = value;
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

  // Método auxiliar que retorna o Widget correto baseado no índice
  Widget _selecionarTela(int index) {
    switch (index) {
      case 0:
        return const ListaExerciciosPage(); // Página de Exercícios
      case 1:
        return TreinoPage(user: widget.user); // Página de Treinos
      case 2:
        return Center(
          child: Text(
            "OLA USUARIO : ${widget.user.username}",
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
