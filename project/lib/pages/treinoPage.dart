import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/models/exercicio.dart';
import 'package:project/models/usuario.dart';
import 'package:project/pages/MontagemTreino.dart';
import 'package:project/pages/PlayTrainpage.dart';

class Treino {
  final String titulo;
  final String nome;
  final String detalhes;
  final List<Exercicio> exercicios;

  Treino(this.titulo, this.nome, this.detalhes, this.exercicios);
}

class TreinoPage extends StatefulWidget {
  final UserModel user;
  const TreinoPage({super.key, required this.user});

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  List<Treino> treinos = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTreinos();
  }

  Future<void> _loadTreinos() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
          'https://izigym-backend.globeapp.dev/treino?user=${widget.user.username}',
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> treinosData = responseData['response'];

        final List<Treino> fetchedTreinos = treinosData.map((treinoData) {
          final String nomeTreino =
              treinoData['nomeTreino'] ?? 'Nome não informado';
          final String descricaoTreino =
              treinoData['descricao'] ?? 'Sem descrição';

          // 🚨 PASSO 1: Mapear os dados de exercício da API para objetos Exercicio
          final List<dynamic> exerciciosRaw = treinoData['exercicios'] ?? [];
          final List<Exercicio> exerciciosCompletos = exerciciosRaw
              .where((item) => item is Map<String, dynamic>)
              .map((item) => Exercicio.fromJson(item as Map<String, dynamic>))
              .toList();

          // PASSO 2: Criar a string de detalhes com a contagem correta
          final int numExercicios = exerciciosCompletos.length;
          final String detalhes = '$numExercicios exercícios';

          // PASSO 3: Criar o objeto Treino (Usando o construtor corrigido)
          return Treino(
            nomeTreino,
            descricaoTreino,
            detalhes,
            exerciciosCompletos,
          );
        }).toList();

        setState(() {
          treinos = fetchedTreinos;
        });
      } else {
        print('Falha ao carregar os treinos: ${response.statusCode}');
        setState(() {
          treinos = [];
        });
      }
    } catch (e) {
      print('Erro de conexão ao carregar treinos: $e');
      setState(() {
        treinos = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Treinos")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : treinos.isEmpty
          ? Center(child: Text("Nenhum treino encontrado. Adicione um novo!"))
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: treinos.length,
              itemBuilder: (context, index) {
                final treino = treinos[index];

                return Card(
                  elevation: 4,
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // 🚨 Adiciona InkWell para ser clicável
                  child: InkWell(
                    onTap: () {
                      // Navega para a Playtrainpage, passando os exercícios
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              Playtrainpage(exerTrain: treino.exercicios),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            treino.titulo,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(treino.nome, style: TextStyle(fontSize: 15)),
                          SizedBox(height: 8),
                          Text(
                            treino.detalhes,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_rounded),
        onPressed: () async {
          final bool? treinoAdicionado =
              await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MontagemTreino(user: widget.user),
                    ),
                  )
                  as bool?;

          if (treinoAdicionado == true) {
            _loadTreinos();
          }
        },
      ),
    );
  }
}
