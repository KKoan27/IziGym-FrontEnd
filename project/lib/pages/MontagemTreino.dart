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
                          final exerciciosSelecionados = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return AdicionaExercicio();
                              },
                            ),
                          );

                          // Verifique se o usuário não voltou sem salvar
                          if (exerciciosSelecionados != null) {
                            var result =
                                exerciciosSelecionados
                                    as List<Map<String, dynamic>>;

                            for (var exercicio in exerciciosSelecionados) {
                              exercicio['intervalo'] = ValueNotifier<int>(0);
                              exercicio['repeticoes'] = ValueNotifier<int>(0);
                            }
                            setState(() {
                              bodyExercicios = exerciciosSelecionados;
                            });
                          }
                        }),
                        child: Text("Adicionar Exercicios"),
                      ),
                      Expanded(
                        child: bodyExercicios.isNotEmpty
                            ? ListView.builder(
                                itemBuilder: (context, index) {
                                  // Declarando as ValueNotifier para ser usado no intervalo e repeticoes
                                  final ValueNotifier<int> intervaloCrtl =
                                      bodyExercicios[index]['intervalo']
                                          as ValueNotifier<int>;
                                  final ValueNotifier<int> repeticoesCrtl =
                                      bodyExercicios[index]['repeticoes']
                                          as ValueNotifier<int>;
                                  return Card(
                                    child: ListTile(
                                      minLeadingWidth: 300,
                                      title: Text(
                                        bodyExercicios[index]['nome'] as String,
                                      ),
                                      trailing: SizedBox(
                                        width: 300,
                                        child: Row(
                                          children: [
                                            //INTERVALO
                                            IconButton(
                                              onPressed: () {
                                                if (intervaloCrtl.value > 0) {
                                                  intervaloCrtl.value -= 1;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.exposure_minus_1,
                                              ),
                                            ),

                                            ValueListenableBuilder(
                                              valueListenable: intervaloCrtl,
                                              builder:
                                                  (context, value, child) =>
                                                      Text(
                                                        '$value Minutos',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                intervaloCrtl.value += 1;
                                              },
                                              icon: Icon(Icons.plus_one),
                                            ),
                                            // REPETIÇÕES
                                            IconButton(
                                              onPressed: () {
                                                if (repeticoesCrtl.value > 0) {
                                                  repeticoesCrtl.value -= 1;
                                                }
                                              },
                                              icon: Icon(
                                                Icons.exposure_minus_1,
                                              ),
                                            ),

                                            ValueListenableBuilder(
                                              valueListenable: repeticoesCrtl,
                                              builder:
                                                  (context, value, child) =>
                                                      Text(
                                                        '$value repeticoes',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                repeticoesCrtl.value += 1;
                                              },
                                              icon: Icon(Icons.plus_one),
                                            ),
                                          ],
                                        ),
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
