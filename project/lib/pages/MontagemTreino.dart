import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/pages/AdicionaExercicio.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/usuario.dart';
import 'package:project/pages/HomePage.dart';

class MontagemTreino extends StatefulWidget {
  final UserModel user;
  const MontagemTreino({super.key, required this.user});

  @override
  State<MontagemTreino> createState() {
    return MontagemTreinoState();
  }
}

class MontagemTreinoState extends State<MontagemTreino> {
  late TextEditingController nomeTreino;
  late TextEditingController descricaoTreino;

  String? selectItem;
  List<Map<String, dynamic>> bodyExercicios = [];

  @override
  void dispose() {
    nomeTreino.dispose();
    descricaoTreino.dispose();
    for (var exercicio in bodyExercicios) {
      if (exercicio.containsKey('intervalo')) {
        (exercicio['intervalo'] as ValueNotifier).dispose();
      }
      if (exercicio.containsKey('repeticoes')) {
        (exercicio['repeticoes'] as ValueNotifier).dispose();
      }
    }
    super.dispose();
  }

  @override
  void initState() {
    nomeTreino = TextEditingController();
    descricaoTreino = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cancelar')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          height: 400,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.start,
                "Criar Novo Treino",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          entradaDeDados(
                            "Nome do treino",
                            Icons.edit_sharp,
                            nomeTreino,
                          ),
                          SizedBox(height: 50),
                          entradaDeDados(
                            "Descrição",
                            Icons.list,
                            descricaoTreino,
                          ),

                          Expanded(
                            // Linha de botões : Adicionar Exercicio, Salvar treinos
                            child: Row(
                              spacing: 50,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // LISTA DE EXERCICIO
                                ElevatedButton(
                                  onPressed: (() async {
                                    final exerciciosSelecionados =
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return AdicionaExercicio();
                                            },
                                          ),
                                        );

                                    // Verifique se o usuário não voltou sem salvar
                                    if (exerciciosSelecionados != null) {
                                      exerciciosSelecionados
                                          as List<Map<String, dynamic>>;

                                      for (var exercicio
                                          in exerciciosSelecionados) {
                                        exercicio['intervalo'] =
                                            ValueNotifier<int>(0);
                                        exercicio['repeticoes'] =
                                            ValueNotifier<int>(0);
                                      }
                                      setState(() {
                                        bodyExercicios = exerciciosSelecionados;
                                      });
                                    }
                                  }),

                                  child: Text("Adicionar Exercicios"),
                                ),
                                // ENVIAR TREINO
                                ElevatedButton(
                                  onPressed: () {
                                    treinoPOST(context);
                                  },
                                  child: Text("Salvar treino"),
                                ),
                              ],
                            ),
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
                                            bodyExercicios[index]['nome']
                                                as String,
                                          ),
                                          trailing: SizedBox(
                                            width: 350, // IMPORTANTISSIMO!!
                                            child: Row(
                                              children: [
                                                //INTERVALO
                                                IconButton(
                                                  onPressed: () {
                                                    if (intervaloCrtl.value >
                                                        0) {
                                                      intervaloCrtl.value -= 1;
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.exposure_minus_1,
                                                  ),
                                                ),

                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      intervaloCrtl,
                                                  builder:
                                                      (
                                                        context,
                                                        value,
                                                        child,
                                                      ) => Text(
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
                                                    if (repeticoesCrtl.value >
                                                        0) {
                                                      repeticoesCrtl.value -= 1;
                                                    }
                                                  },
                                                  icon: Icon(
                                                    Icons.exposure_minus_1,
                                                  ),
                                                ),
                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      repeticoesCrtl,
                                                  builder:
                                                      (
                                                        context,
                                                        value,
                                                        child,
                                                      ) => Text(
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
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Selecione os exercicios",
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> treinoPOST(BuildContext context) async {
    List<Map<String, dynamic>> exerciciosList = bodyExercicios.map((ex) {
      int intervalo = (ex['intervalo'] as ValueNotifier<int>).value;
      int repeticoes = (ex['repeticoes'] as ValueNotifier<int>).value;
      return {
        'nome': ex['nome'],
        'repeticoes': repeticoes,
        'intervalo': intervalo,
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      'nome': widget.user.username,
      'nomeTreino': nomeTreino.text,
      'descricao': descricaoTreino.text, // Adicionando a descrição
      'exercicios': exerciciosList,
    };

    final requestJson = jsonEncode(requestBody);

    try {
      final response = await http.post(
        Uri.parse('https://izigym-backend.globeapp.dev/treino'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: requestJson,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Treino criado com sucesso!")),
        );
        await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(user: widget.user),
              ),
            )
            as bool?;
      } else {
        throw Exception("Erro na requisição, ${response.statusCode}");
      }
    } on Exception catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erro na conexão: $e")));
    }
  }

  Widget entradaDeDados(
    String texto,
    IconData? icone,
    TextEditingController controller,
  ) {
    return Card(
      elevation: 2,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(label: Text(texto), icon: Icon(icone)),
      ),
    );
  }
}
