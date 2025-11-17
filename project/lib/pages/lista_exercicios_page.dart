import 'package:flutter/material.dart';
import 'package:project/models/exercicio.dart';
import 'package:project/services/exercicio_service.dart';
import 'package:project/pages/detalhe_exercicio_page.dart';

class ListaExerciciosPage extends StatefulWidget {
  const ListaExerciciosPage({super.key});

  @override
  State<ListaExerciciosPage> createState() => _ListaExerciciosPageState();
}

class _ListaExerciciosPageState extends State<ListaExerciciosPage> {
  // Instancia o serviço
  final ExercicioService _exercicioService = ExercicioService();

  // 'late' indica que vamos inicializar essa variável antes de usá-la
  late Future<List<Exercicio>> _futureExercicios;

  @override
  void initState() {
    super.initState();
    // Inicia a busca pelos dados assim que a tela é construída
    _futureExercicios = _exercicioService.fetchExercicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Fundos já vêm da HomePage
      appBar: AppBar(
        title: Text(
          "Exercícios",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        // TODO: Adicionar um campo de busca (TextField)
        // que pode chamar _exercicioService.fetchExercicios(query: 'novaQuery')
      ),
      body: FutureBuilder<List<Exercicio>>(
        future: _futureExercicios,
        builder: (context, snapshot) {
          // 1. Enquanto está carregando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color(0xFFE50000), // Vermelho do seu login
              ),
            );
          }

          // 2. Se deu erro
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar dados: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          // 3. Se os dados chegaram, mas estão vazios
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum exercício encontrado.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          // 4. Se tudo deu certo, exibe a lista!
          final exercicios = snapshot.data!;

          return ListView.builder(
            itemCount: exercicios.length,
            itemBuilder: (context, index) {
              final exercicio = exercicios[index];
              return Card(
                color: Color(0xFF1C1C1C), // Cinza escuro do seu login
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  // TODO: Usar o exercicio.gifUrl para mostrar uma miniatura
                  // leading: Image.network(exercicio.gifUrl, width: 50, height: 50),
                  title: Text(
                    exercicio.nome,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    exercicio.musculosAlvo.join(', '),
                    style: TextStyle(color: Colors.white70),
                  ),
                  trailing: Icon(Icons.chevron_right, color: Color(0xFFE50000)),
                  onTap: () {
                    print("CLICOU NO EXERCÍCIO: ${exercicio.nome}");
                    // AÇÃO: Navegar para a tela de detalhes

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetalheExercicioPage(exercicio: exercicio),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
