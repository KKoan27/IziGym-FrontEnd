import 'dart:convert';

List<Exercicio> exercicioFromJson(String str) {
  final decoded = json.decode(str);

  // BLINDAGEM: Verifica se é um Mapa (formato antigo ou erro) ou Lista (novo)
  if (decoded is Map<String, dynamic>) {
    // Se tiver a chave 'response', usa ela. Senão, retorna lista vazia para não quebrar.
    if (decoded.containsKey('response')) {
      return List<Exercicio>.from(
        (decoded['response'] as List).map((x) => Exercicio.fromJson(x)),
      );
    }
    return []; // Retorna vazio se for um objeto desconhecido
  } else if (decoded is List) {
    // Formato novo (Lista direta)
    return List<Exercicio>.from(decoded.map((x) => Exercicio.fromJson(x)));
  } else {
    return [];
  }
}

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
      //  Uso de '??' (operador de coalescência nula).
      // Se o campo "_id" vier nulo da API, usamos '' string vazia para o app não quebrar.
      id: json["_id"] ?? '',

      nome: json["nome"] ?? 'Sem nome',

      descricao: json["descricao"] ?? 'Sem descrição disponível.',
      //  Uso de '??' (operador de coalescência nula).
      // Se o campo "_id" vier nulo da API, usamos '' string vazia para o app não quebrar.
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
