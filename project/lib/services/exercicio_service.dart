import 'package:http/http.dart' as http;
import 'package:project/models/exercicio.dart';

class ExercicioService {
  // url do backend
  final String _baseUrl = "https://izigym-backend.globeapp.dev";

  Future<List<Exercicio>> fetchExercicios({String query = ''}) async {
    //  rota baseada no seu link é /getexercicios
    //  query string foi adicionada apenas se o usuário digitar algo
    String endpoint = '$_baseUrl/getexercicios';
    if (query.isNotEmpty) {
      endpoint += '?q=$query';
    }

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      return exercicioFromJson(response.body);
    } else {
      throw Exception('Falha ao carregar: ${response.statusCode}');
    }
  }
}
