import 'package:flutter/material.dart';

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("PAGINA DE TREINO")),
      floatingActionButton: FloatingActionButton.large(
        child: Icon(Icons.playlist_add_rounded),
        onPressed: (() {
          Navigator.pushNamed(context, '/addtreino');
        }),
      ),
    );
  }
}
