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
      // 1. MUDANÇA: SingleChildScrollView envolve tudo para evitar erro com teclado
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Criar Novo Treino",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              const SizedBox(height: 16),

              entradaDeDados("Nome do treino", Icons.edit_sharp, nomeTreino),
              const SizedBox(height: 20),
              entradaDeDados("Descrição", Icons.list, descricaoTreino),
              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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

                      if (exerciciosSelecionados != null) {
                        final List<Map<String, dynamic>> novosExercicios =
                            exerciciosSelecionados
                                as List<Map<String, dynamic>>;

                        for (var exercicio in novosExercicios) {
                          if (!exercicio.containsKey('intervalo')) {
                            exercicio['intervalo'] = ValueNotifier<int>(0);
                          }
                          if (!exercicio.containsKey('repeticoes')) {
                            exercicio['repeticoes'] = ValueNotifier<int>(0);
                          }
                        }

                        setState(() {
                          bodyExercicios = novosExercicios;
                        });
                      }
                    }),
                    child: Text("Adicionar Exercicios"),
                  ),
                  const SizedBox(width: 20), // Ajustei levemente o espaçamento
                  ElevatedButton(
                    onPressed: () {
                      treinoPOST(context);
                    },
                    child: Text("Salvar treino"),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. MUDANÇA: Removemos o Expanded aqui. A lista rola junto com a página.
              bodyExercicios.isNotEmpty
                  ? ListView.builder(
                      // Essas duas linhas fazem a lista ocupar só o espaço necessário
                      // e não ter rolagem interna (quem rola é a página toda)
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final ValueNotifier<int> intervaloCrtl =
                            bodyExercicios[index]['intervalo']
                                as ValueNotifier<int>;
                        final ValueNotifier<int> repeticoesCrtl =
                            bodyExercicios[index]['repeticoes']
                                as ValueNotifier<int>;

                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            title: Text(
                              bodyExercicios[index]['nome'] as String,
                            ),

                            // 3. MUDANÇA: Reduzi de 250 para 170 para caber em telas menores
                            trailing: SizedBox(
                              width: 170,
                              child: Row(
                                children: [
                                  // --- Controles de INTERVALO ---
                                  Expanded(
                                    child: Column(
                                      // Mudei para Column para economizar largura se precisar
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Min",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              // Troquei IconButton por InkWell para tirar padding extra
                                              onTap: () {
                                                if (intervaloCrtl.value > 0)
                                                  intervaloCrtl.value -= 1;
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            ValueListenableBuilder(
                                              valueListenable: intervaloCrtl,
                                              builder:
                                                  (context, value, child) =>
                                                      Text(
                                                        '$value',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                            ),
                                            const SizedBox(width: 4),
                                            InkWell(
                                              onTap: () {
                                                intervaloCrtl.value += 1;
                                              },
                                              child: Icon(Icons.add, size: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const VerticalDivider(
                                    width: 10,
                                    thickness: 1,
                                  ),

                                  // --- Controles de REPETIÇÕES ---
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Reps",
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (repeticoesCrtl.value > 0)
                                                  repeticoesCrtl.value -= 1;
                                              },
                                              child: Icon(
                                                Icons.remove,
                                                size: 16,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            ValueListenableBuilder(
                                              valueListenable: repeticoesCrtl,
                                              builder:
                                                  (context, value, child) =>
                                                      Text(
                                                        '$value',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                            ),
                                            const SizedBox(width: 4),
                                            InkWell(
                                              onTap: () {
                                                repeticoesCrtl.value += 1;
                                              },
                                              child: Icon(Icons.add, size: 16),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: bodyExercicios.length,
                    )
                  : Center(
                      child: Text(
                        "Selecione os exercícios",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> treinoPOST(BuildContext context) async {
    List<Map<String, dynamic>> exerciciosPayload = bodyExercicios.map((ex) {
      int intervalo = (ex['intervalo'] as ValueNotifier<int>).value;
      int repeticoes = (ex['repeticoes'] as ValueNotifier<int>).value;

      return {
        'id': ex['_id'],
        'nome': ex['nome'],
        'repeticoes': repeticoes,
        'intervalo': intervalo,
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      'nome': widget.user.username,
      'nomeTreino': nomeTreino.text,
      'descricao': descricaoTreino.text,
      'exercicios': exerciciosPayload,
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
        Navigator.pop(context, true);
      } else {
        throw Exception(
          "Erro na requisição: ${response.statusCode}. Corpo: ${response.body}",
        );
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
        decoration: InputDecoration(
          label: Text(texto),
          icon: Icon(icone),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
