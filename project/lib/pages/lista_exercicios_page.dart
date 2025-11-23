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
  final ExercicioService _exercicioService = ExercicioService();
  late Future<List<Exercicio>> _futureExercicios;

  @override
  void initState() {
    super.initState();
    _futureExercicios = _exercicioService.fetchExercicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          "Exercícios",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Exercicio>>(
        future: _futureExercicios,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFE50000)),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erro ao carregar dados.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum exercício encontrado.',
                style: TextStyle(color: Colors.white70),
              ),
            );
          }

          final exercicios = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: exercicios.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final exercicio = exercicios[index];
              return _buildExercicioCard(context, exercicio);
            },
          );
        },
      ),
    );
  }

  Widget _buildExercicioCard(BuildContext context, Exercicio exercicio) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalheExercicioPage(exercicio: exercicio),
          ),
        );
      },
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // 1. Imagem/GIF à Esquerda
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: SizedBox(
                width: 120,
                height: double.infinity,
                child: exercicio.gifUrl.isNotEmpty
                    ? Image.network(
                        exercicio.gifUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              Icons.image_not_supported,
                              color: Colors.white24,
                            ),
                      )
                    : const Icon(
                        Icons.fitness_center,
                        color: Colors.white24,
                        size: 40,
                      ),
              ),
            ),

            // 2. Informações no Centro
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      exercicio.nome,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      exercicio.musculosAlvo.isNotEmpty
                          ? exercicio.musculosAlvo.join(", ")
                          : "Geral",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),

            // 3. Ícone indicativo à direita
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFE50000),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
