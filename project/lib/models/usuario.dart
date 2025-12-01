import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final double altura;
  final double peso;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.altura,
    required this.peso,
  });

  // Construtor Factory para criar o objeto a partir da resposta JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // MongoDB ObjectId é convertido para String
      id: json['id'].toString(),
      username: json['username'] as String,
      email: json['email'] as String,
      // Conversão segura de num (int ou double) para double
      altura: (json['altura'] as num).toDouble(),
      peso: (json['peso'] as num).toDouble(),
    );
  }

  // Método para converter o objeto em Map para salvar no SharedPreferences
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'altura': altura,
      'peso': peso,
    };
  }

  // Salva o objeto UserModel no SharedPreferences
  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    // Salva o JSON do usuário como uma String
    await prefs.setString('currentUser', jsonEncode(toJson()));
    await prefs.setBool('isLoggedIn', true);
  }

  // Recupera o objeto UserModel do SharedPreferences
  static Future<UserModel?> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');
    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
