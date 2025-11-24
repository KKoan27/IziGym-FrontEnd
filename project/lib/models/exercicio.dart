// Define como são os dados
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
      //  Uso de '??' (operador de coalescência nula).
      // Se o campo "_id" vier nulo da API, usamos '' string vazia para o app não quebrar.
      id: json["_id"] ?? '',

      nome: json["nome"] ?? 'Sem nome',

      descricao: json["descricao"] ?? 'Sem descrição disponível.',

      // [SEGURANÇA] Conversão robusta de Listas.
      // Se vier null (as List?), fazemos map para String. Se falhar, retorna lista vazia [].
      musculosAlvo:
          (json["musculosAlvo"] as List?)
              ?.map((item) => item.toString())
              .toList() ??
          [],

      gifUrl: json["execucao"] ?? '',

      dicas:
          (json["dicas"] as List?)?.map((item) => item.toString()).toList() ??
          [],
    );
  }
}
