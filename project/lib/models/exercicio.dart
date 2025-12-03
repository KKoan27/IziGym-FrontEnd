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
  final String? id;
  final String nome;
  final String descricao;
  final List<String> musculosAlvo;
  final String gifUrl;
  final List<String> dicas;

  final int? repeticoes;
  final int? intervalo;

  Exercicio({
    this.id,
    required this.nome,
    required this.descricao,
    required this.musculosAlvo,
    required this.gifUrl,
    this.dicas = const [],

    this.repeticoes,
    this.intervalo,
  });
  factory Exercicio.fromJson(Map<String, dynamic> json) {
    return Exercicio(
      // Campos obrigatórios (assumindo que nunca são nulos no JSON, ou que você fornece um fallback)
      id: json["_id"] ?? '',
      nome: json["nome"] ?? 'Sem nome',
      descricao: json["descricao"] ?? 'Sem descrição disponível.',
      gifUrl: json["execucao"] ?? '',

      // Conversões para Listas (com fallback para lista vazia)
      musculosAlvo:
          (json["musculosAlvo"] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          [],
      dicas:
          (json["dicas"] as List?)?.map((item) => item.toString()).toList() ??
          [],

      // 🚨 Tratamento de Inteiros Opcionais (Int?) 🚨
      // 1. Acessa a chave no mapa (json['repeticoes']).
      // 2. Tenta fazer o casting para 'int?'. Se a chave não existir ou for null, o resultado é null.
      // O Dart 3.x+ e o Null Safety fazem isso de forma robusta:
      repeticoes: json['repeticoes'] as int?,
      intervalo: json['intervalo'] as int?,
    );
  }
}
