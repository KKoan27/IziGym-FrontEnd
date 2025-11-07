import 'package:flutter/material.dart';

class Adicionaexercicio extends StatelessWidget {
  const Adicionaexercicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // A seta que faz navigation pop vem por uma prop que tem por padrão true (Isso me surpreendeu)
        title: Title(color: Colors.red, child: Text("Selecione os exercicios")),
      ),
      body: Column(
        children: List.generate(10, (index) {
          return Text("CARTAO $index", textDirection: TextDirection.ltr);
        }),
      ),
    );
  }
}
