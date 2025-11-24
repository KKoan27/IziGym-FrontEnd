import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/models/usuario.dart'; // Certifique-se de importar o modelo

// URL base da sua API
const String _baseUrl = "https://izigym-backend.globeapp.dev/user";

/**
 * Realiza o login do usuário.
 * * @param email O email fornecido pelo usuário.
 * @param senha A senha fornecida pelo usuário.
 * @param context O contexto para exibir SnackBars.
 * @return O UserModel se o login for bem-sucedido, ou null caso contrário.
 */
Future<UserModel?> login(
  String email,
  String senha,
  BuildContext context,
) async {
  final Map<String, String> requestBody = {"email": email, "senha": senha};

  // Seu backend usa "authuser" como op (operação), vamos usá-lo na URL
  final Uri uri = Uri.parse('$_baseUrl?op=authuser');

  try {
    var result = await http.post(
      uri,
      body: jsonEncode(requestBody), // Envia JSON
      headers: {'Content-Type': 'application/json'},
    );

    // Seu backend retorna 200 (OK) para sucesso e 401 (Unauthorized) para falha.
    if (result.statusCode == 200) {
      // Sucesso no Login
      final jsonResponse = jsonDecode(result.body);

      final userDataMap = jsonResponse['response'] as Map<String, dynamic>?;

      if (userDataMap != null) {
        // O backend retorna o Map direto, não aninhado em 'response' ou 'data'
        final UserModel user = UserModel.fromJson(userDataMap);

        // 🔑 Salvar dados no SharedPreferences
        await user.saveToPrefs();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("👋 Bem-vindo(a), ${user.username}!")),
        );

        return user;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Resposta do servidor incompleta.")),
        );
        return null;
      }
    } else if (result.statusCode == 401) {
      // Credenciais Inválidas (Email não encontrado ou Senha incorreta)
      // Seu backend retorna a mensagem de erro como uma String no body
      String errorMessage = jsonDecode(result.body);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("❌ $errorMessage")));
      return null;
    } else {
      // Outros Erros de Servidor (400, 500 etc.)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "❌ Erro ${result.statusCode}: Falha na comunicação com o servidor.",
          ),
        ),
      );
      return null;
    }
  } catch (e, s) {
    // Falha de Conexão (servidor offline, rede indisponível)

    print("\n $e \n $s");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("⚠️ Falha na conexão. Verifique a URL do servidor."),
      ),
    );
    return null;
  }
}
