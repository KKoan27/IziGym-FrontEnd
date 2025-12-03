import 'package:flutter/material.dart';
import 'package:project/models/exercicio.dart';

class Playtrainpage extends StatefulWidget {
  // A lista de Exercicios com repetições e intervalo
  final List<Exercicio> exerTrain;

  const Playtrainpage({super.key, required this.exerTrain});

  @override
  State<Playtrainpage> createState() => PlaytrainpageState();
}

class PlaytrainpageState extends State<Playtrainpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Iniciando Treino")),
      body: widget.exerTrain.isEmpty
          ? const Center(
              child: Text("Nenhum exercício encontrado para este treino."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: widget.exerTrain.length,
              itemBuilder: (context, index) {
                final exercicio = widget.exerTrain[index];

                final String repeticoes = exercicio.repeticoes != null
                    ? "${exercicio.repeticoes} Reps"
                    : "Série não definida";
                final String intervalo = exercicio.intervalo != null
                    ? "${exercicio.intervalo} seg. descanso"
                    : "Sem descanso";

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    // 🚨 IMPLEMENTAÇÃO DA IMAGEM DA REDE 🚨
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        8.0,
                      ), // Borda arredondada
                      child: SizedBox(
                        width: 50, // Tamanho fixo para o leading
                        height: 50,
                        // Image.network é o mais simples
                        child: Image.network(
                          exercicio.gifUrl, // A URL do GIF/Imagem
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            // Mostra um indicador de progresso enquanto carrega
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value:
                                    loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            // Mostra um ícone em caso de erro no carregamento
                            return const Icon(Icons.broken_image, size: 40);
                          },
                        ),
                      ),
                    ),

                    // Nome do Exercício
                    title: Text(
                      exercicio.nome,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),

                    // Detalhes
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(repeticoes),
                        Text(intervalo),
                      ],
                    ),

                    trailing: const Icon(Icons.fitness_center),

                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Iniciar: ${exercicio.nome}")),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
