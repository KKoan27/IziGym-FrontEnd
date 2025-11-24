import 'dart:convert';

// tratamento da api de exercicios
List<Exercicio> exercicioFromJson(String str) =>
    List<Exercicio>.from(json.decode(str).map((x) => Exercicio.fromJson(x)));

class Exercicio {
  final String id;
  final String nome;
  final String descricao;
  final List<String> musculosAlvo;
  final String gifUrl; // O JSON chama de "execucao"
  final List<String> errosComuns;

  Exercicio({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.musculosAlvo,
    required this.gifUrl,
    this.errosComuns = const [],
  });

  factory Exercicio.fromJson(Map<String, dynamic> json) => Exercicio(
    id: json["_id"] ?? '',
    nome: json["nome"] ?? 'Sem nome',
    descricao: json["descricao"] ?? 'Sem descrição disponível.',
    // O JSON traz uma lista de strings para musculosAlvo
    musculosAlvo: List<String>.from(json["musculosAlvo"] ?? []),
    //  "execucao" do JSON para a variável gifUrl
    gifUrl: json["execucao"] ?? '',
    errosComuns: [],
  );
}
