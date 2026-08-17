import 'dart:convert';

import 'exercicio.dart';

List<Treino> treinoFromJson(String str) {
  final decoded = json.decode(str);

  if (decoded is Map<String, dynamic>) {
    dynamic bodyData = decoded['body'];

    if (bodyData is List) {
      return List<Treino>.from(
        bodyData.map((item) => Treino.fromJson(item as Map<String, dynamic>)),
      );
    }

    if (decoded.containsKey('response')) {
      final response = decoded['response'];
      if (response is List) {
        return List<Treino>.from(
          response.map((item) => Treino.fromJson(item as Map<String, dynamic>)),
        );
      }
    }

    return [];
  }

  if (decoded is List) {
    return List<Treino>.from(
      decoded.map((item) => Treino.fromJson(item as Map<String, dynamic>)),
    );
  }

  return [];
}

class Treino {
  final String nomeTreino;
  final String userId;
  final List<Exercicio> exercicios;

  Treino({
    required this.nomeTreino,
    required this.userId,
    required this.exercicios,
  });

  factory Treino.fromJson(Map<String, dynamic> json) {
    final exerciciosRaw = json['exercicios'] as List? ?? [];

    return Treino(
      nomeTreino: json['nomeTreino']?.toString() ?? 'Treino sem nome',
      userId: json['userId']?.toString() ?? '',
      exercicios: exerciciosRaw
          .map((item) => Exercicio.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}
