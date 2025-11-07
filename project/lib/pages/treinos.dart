import 'package:flutter/material.dart';
import 'package:project/pages/AdicionaExercicio.dart';

void main() {
  runApp(Scaffold(MontagemTreino)) {}
}

class MontagemTreino extends StatefulWidget {
  const MontagemTreino({super.key});

  @override
  State<MontagemTreino> createState() {
    return MontagemTreinoState();
  }
}

class MontagemTreinoState extends State<MontagemTreino> {
  String nomeTreino = "";
  String? selectItem;
  List<String> _items = ['Option 1', 'Option 2', 'Option 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(child: Text("Criar Novo Treino")),
          Column(
            children: [
              TextField(
                onChanged: (value) => nomeTreino = value,
                decoration: InputDecoration(
                  label: Text(
                    "Nome do Treino",
                    textDirection: TextDirection.ltr,
                  ),
                  icon: Icon(Icons.edit),
                ),
              ),

              DropdownButton<String>(
                value: selectItem,
                icon: Icon(Icons.list_rounded),
                items: _items.map((String i) {
                  return DropdownMenuItem<String>(value: i, child: Text(i));
                }).toList(),
                onChanged: ((String? newValue) => setState(() {
                  selectItem = newValue;
                })),
              ),
              TextField(
                onChanged: (value) => nomeTreino = value,
                decoration: InputDecoration(
                  label: Text("Descrição", textDirection: TextDirection.ltr),
                  icon: Icon(Icons.description),
                ),
              ),
              ElevatedButton(
                onPressed: (() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Adicionaexercicio();
                      },
                    ),
                  );
                }),
                child: Text("Adicionar Exercicios"),
              ),
            ],
          ),
          Container(child: Text("Ola mundo3")),
        ],
      ),
    );
  }
}
