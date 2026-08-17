import 'package:http/http.dart' as http;
import 'package:project/models/treino.dart';
import 'package:project/models/usuario.dart';

class TreinoService {
  final String _baseUrl = 'http://127.0.0.1:8090/api/treino';

  Future<List<Treino>> fetchTreinos() async {
    final user = await UserModel.loadFromPrefs();
    final userId = user?.id ?? '';
    final token = user?.token ?? '';

    if (userId.isEmpty) {
      return [];
    }

    final uri = Uri.parse(_baseUrl).replace(
      queryParameters: {
        'userid': userId,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return treinoFromJson(response.body);
    }

    throw Exception('Falha ao carregar treinos: ${response.statusCode}');
  }
}