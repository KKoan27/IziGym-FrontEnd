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
        // 🚨 REMOVIDO: SizedBox(height: 400) para usar a altura total da tela
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Criar Novo Treino",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            const SizedBox(height: 16),

            // Campos de Entrada (Altura definida pelo conteúdo)
            entradaDeDados("Nome do treino", Icons.edit_sharp, nomeTreino),
            const SizedBox(height: 20),
            entradaDeDados("Descrição", Icons.list, descricaoTreino),
            const SizedBox(height: 30),

            // Linha de botões (Altura definida pelo conteúdo)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // LISTA DE EXERCICIO
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
                      final List<Map<String, dynamic>> novosExercicios =
                          exerciciosSelecionados as List<Map<String, dynamic>>;

                      // Inicializa ValueNotifiers para os novos exercícios
                      for (var exercicio in novosExercicios) {
                        // Verifica se a chave já foi inicializada para evitar erro
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
                const SizedBox(width: 50),
                // ENVIAR TREINO
                ElevatedButton(
                  onPressed: () {
                    treinoPOST(context);
                  },
                  child: Text("Salvar treino"),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // 🚨 EXPANDED FINAL: A lista de exercícios ocupa o espaço restante
            Expanded(
              // Removido o Expanded aninhado. A lista agora tem espaço para rolar.
              child: bodyExercicios.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        // Declarações (castings corrigidos)
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
                            // Removido minLeadingWidth e minTileHeight para evitar problemas de layout
                            title: Text(
                              bodyExercicios[index]['nome'] as String,
                            ),

                            // 🚨 AJUSTE DE OVERFLOW: Usando Expanded dentro do Row de trailing
                            trailing: SizedBox(
                              width:
                                  250, // Tamanho que deve caber na maioria das telas
                              child: Row(
                                children: [
                                  // --- Controles de INTERVALO ---
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (intervaloCrtl.value > 0) {
                                              intervaloCrtl.value -= 1;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.exposure_minus_1,
                                            size: 18,
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: intervaloCrtl,
                                          builder: (context, value, child) =>
                                              Text(
                                                '$value Min',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            intervaloCrtl.value += 1;
                                          },
                                          icon: Icon(Icons.plus_one, size: 18),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // --- Controles de REPETIÇÕES ---
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (repeticoesCrtl.value > 0) {
                                              repeticoesCrtl.value -= 1;
                                            }
                                          },
                                          icon: Icon(
                                            Icons.exposure_minus_1,
                                            size: 18,
                                          ),
                                        ),
                                        ValueListenableBuilder(
                                          valueListenable: repeticoesCrtl,
                                          builder: (context, value, child) =>
                                              Text(
                                                '$value Reps',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            repeticoesCrtl.value += 1;
                                          },
                                          icon: Icon(Icons.plus_one, size: 18),
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
                          fontSize: 24, // Reduzido para caber melhor
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> treinoPOST(BuildContext context) async {
    // 🚨 CONVERSÃO CORRETA: Extrai os valores das ValueNotifier para o JSON
    List<Map<String, dynamic>> exerciciosList = bodyExercicios.map((ex) {
      int intervalo = (ex['intervalo'] as ValueNotifier<int>).value;
      int repeticoes = (ex['repeticoes'] as ValueNotifier<int>).value;

      // Inclui todos os dados do exercício que a API pode precisar (nome, musculosAlvo, etc.)
      return {
        ...ex, // Mantém todas as outras chaves do exercício selecionado (id, musculosAlvo, etc.)
        'repeticoes': repeticoes,
        'intervalo': intervalo,
        // Remove as ValueNotifiers antes do POST para evitar JSON encoding error
        'intervalo': null,
        'repeticoes': null,
      };
    }).toList();

    // Filtra as chaves de ValueNotifier que foram adicionadas e não são JSON serializáveis.
    // O spread '...ex' pode adicionar chaves que não queremos mandar. Vamos ser explícitos:

    // 🚨 RE-MAPEAR PARA O CORPO DO POST (garantindo que apenas dados necessários são enviados)
    List<Map<String, dynamic>> exerciciosPayload = bodyExercicios.map((ex) {
      int intervalo = (ex['intervalo'] as ValueNotifier<int>).value;
      int repeticoes = (ex['repeticoes'] as ValueNotifier<int>).value;

      // Supondo que você precisa do ID ou nome, repetições e intervalo
      return {
        'id': ex['_id'], // Se o seu modelo usa _id para identificação
        'nome': ex['nome'],
        'repeticoes': repeticoes,
        'intervalo': intervalo,
        // Adicione aqui outros campos necessários no payload da API (musculosAlvo, etc.)
      };
    }).toList();

    final Map<String, dynamic> requestBody = {
      'nome': widget.user.username,
      'nomeTreino': nomeTreino.text,
      'descricao': descricaoTreino.text, // Adicionado a descrição
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
        // Retorna true para a tela anterior (TreinoPage) para que ela recarregue a lista
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
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ), // Remove a borda padrão do TextField para manter o estilo do Card
        ),
      ),
    );
  }
}
