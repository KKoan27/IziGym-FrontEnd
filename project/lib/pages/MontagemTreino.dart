import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/pages/AdicionaExercicio.dart';
import 'package:http/http.dart' as http;

class MontagemTreino extends StatefulWidget {
  const MontagemTreino({super.key});

  @override
  State<MontagemTreino> createState() {
    return MontagemTreinoState();
  }
}

class MontagemTreinoState extends State<MontagemTreino> {
  String nomeTreino = "";
  String descricaoTreino = "";
  String? selectItem;
  List<String> _items = ['Option 1', 'Option 2', 'Option 3'];
  List<Map<String, dynamic>> bodyExercicios = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: SizedBox(
            height: 400,
            width: double.infinity,

            child: Column(
              children: [
                Center(
                  child: Text(
                    "Criar Novo Treino",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      entradaDeDados("Nome do treino", Icons.edit_sharp, (
                        value,
                      ) {
                        nomeTreino = value;
                      }),
                      SizedBox(height: 50),
                      entradaDeDados("Descrição", Icons.list, (value) {
                        descricaoTreino = value;
                      }),
                      ElevatedButton(
                        onPressed: (() async {
                          //Receba os dados em uma variável temporária
                          final novosExercicios = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AdicionaExercicio();
                              },
                            ),
                          );

                          // Verifique se o usuário não voltou sem salvar
                          if (novosExercicios != null) {
                            setState(() {
                              bodyExercicios =
                                  novosExercicios as List<Map<String, dynamic>>;
                            });
                          }
                        }),
                        child: Text("Adicionar Exercicios"),
                      ),
                      Expanded(
                        child: bodyExercicios.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      title: Text(
                                        bodyExercicios[index]['nome'] as String,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: bodyExercicios.length,
                              )
                            : Text("Selecione os exercicios"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField entradaDeDados(
    String texto,
    IconData? icone,
    Function(String) onChanged,
  ) {
    return TextField(
      cursorColor: Colors.red,
      onChanged: onChanged,
      decoration: InputDecoration(
        label: Text(texto, style: TextStyle(color: Colors.white)),
        icon: Icon(icone),
      ),
    );
  }
}
