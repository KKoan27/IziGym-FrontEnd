// Define como buscar os dados
import 'package:http/http.dart' as http;
import 'package:project/models/exercicio.dart';

class ExercicioService {
  final String _baseUrl = "https://izigym-backend.globeapp.dev";

  // [ORAL] "O método fetchExercicios aceita um parâmetro opcional 'query'.
  // Isso permite reutilizar a mesma função tanto para listar tudo quanto para filtrar."
  Future<List<Exercicio>> fetchExercicios({String query = ''}) async {
    // [LÓGICA] Construção dinâmica da URL
    String endpoint = '$_baseUrl/getexercicios';
    if (query.isNotEmpty) {
      endpoint += '?q=$query'; // Adiciona Query Param se houver busca
    }

    // [TÉCNICO] await espera a resposta da internet antes de continuar
    final response = await http.get(Uri.parse(endpoint));

    // [ERROS] Verificação do Status Code (200 = OK)
    if (response.statusCode == 200) {
      return exercicioFromJson(response.body);
    } else {
      throw Exception('Falha ao carregar: ${response.statusCode}');
    }
  }
}
