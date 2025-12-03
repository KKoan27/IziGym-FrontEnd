import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Treino {
  final String titulo;
  final String nome;
  final String detalhes;

  Treino(this.titulo, this.nome, this.detalhes);
}

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

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
      // TODO: Substituir 'TesteADM' pelo nome de usuário real ou token de autenticação
      final response = await http.get(Uri.parse('https://izigym-backend.globeapp.dev/treino?user=TesteADM'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final List<dynamic> treinosData = responseData['response'];

        final List<Treino> fetchedTreinos = treinosData.map((treinoData) {
          final String nomeTreino = treinoData['nomeTreino'] ?? 'Nome não informado';
          final String descricaoTreino = treinoData['descricao'] ?? 'Sem descrição';
          final List<dynamic> exercicios = treinoData['exercicios'] ?? [];
          final int numExercicios = exercicios.length;
          final String detalhes = '$numExercicios exercícios';

          // Usando nomeTreino para 'titulo' e descricaoTreino para 'nome' (que era o campo de descrição no mock)
          return Treino(nomeTreino, descricaoTreino, detalhes);
        }).toList();

        setState(() {
          treinos = fetchedTreinos;
        });
      } else {
        // Se a API retornar 404 ou outro erro, apenas limpa a lista e mostra a mensagem de erro.
        print('Falha ao carregar os treinos: ${response.statusCode}');
        setState(() {
          treinos = [];
        });
      }
    } catch (e) {
      // Tratar o erro de conexão
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
                            Text(
                              treino.nome,
                              style: TextStyle(fontSize: 15),
                            ),
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
                    );
                  },
                ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_rounded),
        onPressed: () async {
          // Espera o retorno da tela de adição de treino
          final bool? treinoAdicionado = await Navigator.pushNamed(context, '/addtreino') as bool?;
          
          // Se o treino foi adicionado com sucesso (MontagemTreino retornou true), recarrega a lista
          if (treinoAdicionado == true) {
            _loadTreinos();
          }
        },
      ),
    );
  }
}
