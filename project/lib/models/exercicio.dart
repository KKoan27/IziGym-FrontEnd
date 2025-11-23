import 'dart:convert';

List<Exercicio> exercicioFromJson(String str) =>
    List<Exercicio>.from(json.decode(str).map((x) => Exercicio.fromJson(x)));

class Exercicio {
  final String id;
  final String nome;
  final String descricao;
  final List<String> musculosAlvo;
  final String gifUrl;
  final List<String> dicas;

  Exercicio({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.musculosAlvo,
    required this.gifUrl,
    this.dicas = const [],
  });

  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      id: json["_id"] ?? '',
      nome: json["nome"] ?? 'Sem nome',
      descricao: json["descricao"] ?? 'Sem descrição disponível.',
      // Conversão segura: Se for null, usa []. Se não for lista de strings, converte.
      musculosAlvo:
          (json["musculosAlvo"] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      gifUrl: json["execucao"] ?? '',
      // Conversão segura para dicas também
      dicas:
          (json["dicas"] as List?)?.map((item) => item.toString()).toList() ??
          [],
    );
  }
}
