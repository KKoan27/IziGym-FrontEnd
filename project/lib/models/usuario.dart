import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String? token;
  final double altura;
  final double peso;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.token,
    required this.altura,
    required this.peso,
  });

  factory UserModel.fromJson(Map<String, dynamic> json, {String? token}) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      username:
          json['nome']?.toString() ??
          json['username']?.toString() ??
          '',
      email: json['email']?.toString() ?? '',
      token: token ?? json['token']?.toString(),
      altura: ((json['altura'] ?? 0) as num).toDouble(),
      peso: ((json['peso'] ?? 0) as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson({bool includeToken = false}) {
    return {
      'id': id,
      'nome': username,
      'email': email,
      'altura': altura,
      'peso': peso,
      if (includeToken) 'token': token ?? '',
    };
  }

  Future<void> saveToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('currentUser', jsonEncode(toJson()));
    await prefs.setString('auth_token', token ?? '');
    await prefs.setBool('isLoggedIn', token != null && token!.isNotEmpty);
  }

  static Future<UserModel?> loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('currentUser');

    if (userJson == null) {
      return null;
    }

    final decoded = jsonDecode(userJson);
    final token = prefs.getString('auth_token');

    return UserModel.fromJson(decoded, token: token ?? decoded['token']?.toString());
  }
}

