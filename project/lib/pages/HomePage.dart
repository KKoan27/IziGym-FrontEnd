import 'package:flutter/material.dart';
import 'package:project/pages/MontagemTreino.dart';
import 'package:project/pages/treinoPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int locale = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return (Scaffold(
      body: selectItem(locale),
      backgroundColor: const Color.fromARGB(255, 43, 42, 42),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 100, 100, 100),
        currentIndex: locale,
        selectedItemColor: const Color.fromARGB(255, 170, 45, 36),

        onTap: (value) => setState(() {
          locale = value;
        }),
        items: [
          BottomNavigationBarItem(icon: Text("💪"), label: "Exercicios"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "Treino",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    ));
  }

  Widget selectItem(int index) {
    switch (index) {
      case 0:
        return (Center(
          child: Container(
            child: Text("Exercicios", style: TextStyle(color: Colors.white)),
          ),
        ));
      case 1:
        return Center(child: TreinoPage());
      case 2:
        return Center(
          child: Container(
            child: Text("Perfil", style: TextStyle(color: Colors.white)),
          ),
        );
      default:
        return Center(
          child: Container(
            child: Text(
              "Nao foi em nada",
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
    }
  }
}
