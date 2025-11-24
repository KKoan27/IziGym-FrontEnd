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
      // O body muda dependendo do índice selecionado
      body: _selecionarTela(_indiceAtual),

      // Barra de navegação inferior
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1C1C1C), // Fundo cinza escuro
        currentIndex: _indiceAtual, // Diz à barra qual ícone deve brilhar
        selectedItemColor: const Color(0xFFE50000), // Cor do ícone ativo
        unselectedItemColor: Colors.grey, // Cor dos ícones inativos
        // Função chamada quando clica em um ícone
        onTap: (novoIndice) {
          setState(() {
            _indiceAtual = novoIndice; // Atualiza a variável e redesenha a tela
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Exercícios",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: "Criar Treino",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }

  // Método auxiliar que retorna o Widget correto baseado no índice
  Widget _selecionarTela(int index) {
    switch (index) {
      case 0:
        return const Center(
          child: Text(
            "Lista de Exercícios",
            style: TextStyle(color: Colors.white),
          ),
        );
      case 1:
        return const TreinoPage();
      case 2:
        return Center(
          child: Text(
            "Meu Perfil ${widget.user.username}",
            style: TextStyle(color: Colors.white),
          ),
        );
      default:
        return Container();
    }
  }
}
