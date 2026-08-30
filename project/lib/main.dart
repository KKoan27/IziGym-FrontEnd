import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project/models/treino.dart';
import 'pages/login.dart';
import 'package:project/pages/AdicionaExercicio.dart';
import 'package:project/pages/HomePage.dart';
import 'package:project/pages/MontagemTreino.dart';
import 'package:project/pages/PlayTrainpage.dart';

void main() {
  Map<String, dynamic> Data = {
    "statusCode": 200,
    "body": [
      {
        "nomeTreino": "Treino Teste - B ",
        "userId": "6930cb826370e0eaed000000",
        "exercicios": [
          {
            "nome": "Supino Reto com Barra",
            "musculosAlvo": ["Peitoral", "Tríceps", "Deltoide Anterior"],
            "descricao":
                "Exercício fundamental para o desenvolvimento do peitoral, ombros e tríceps.",
            "execucao":
                "https://kkoan27.github.io/Assets-exercicios/GIFs/SupinoRetoBarra.gif",
            "dicas": null,
            "intervalo": 4,
            "repeticoes": 10,
          },
          {
            "nome": "Remada Serrote com Halter",
            "musculosAlvo": ["Latíssimo do Dorso", "Redondo Maior"],
            "descricao":
                "Exercício unilateral para corrigir assimetrias e dar grande estímulo à espessura da lateral das costas.",
            "execucao":
                "https://kkoan27.github.io/Assets-exercicios/GIFs/RemadaSerroteHalter.gif",
            "dicas": [
              "Mantenha a cabeça em posição neutra e o tronco paralelo ao chão.",
              "Puxe o halter em direção ao quadril, não ao ombro.",
              "Use um peso que permita a máxima amplitude, esticando bem o braço na descida.",
            ],
            "intervalo": 3,
            "repeticoes": 12,
          },
          {
            "nome": "Pullover com Halter",
            "musculosAlvo": [
              "Latíssimo do Dorso",
              "Peitoral Maior",
              "Tríceps Braquial (cabeça longa)",
            ],
            "descricao":
                "Desenvolve a expansão da caixa torácica e trabalha o latíssimo do dorso e o peitoral.",
            "execucao":
                "https://kkoan27.github.io/Assets-exercicios/GIFs/PulloverHalter.gif",
            "dicas": [
              "Segure o halter com as duas mãos em formato de 'diamante'.",
              "Mantenha o quadril baixo e o core ativo.",
              "Não flexione muito os cotovelos; o movimento deve ser amplo.",
            ],
            "intervalo": 6,
            "repeticoes": 20,
          },
        ],
      },
    ],
  };

  Map<String, dynamic> jsontreino = Data['body'][0];

  Treino treino = Treino.fromJson(jsontreino);
  // Treino.fromJson();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,

      // ROTA INICIAL
      initialRoute: '/ExecTreino',

      // DEFINIÇÃO DAS ROTAS
      routes: {
        // '/addtreino': (context) => const MontagemTreino(),
        '/ExecTreino': (context) => Playtrainpage(treino: treino),
      },

      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.red,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50000),
          secondary: Color(0xFFE50000),
          surface: Color(0xFF1C1C1C),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1C1C1C),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 3.0),
          ),
          labelStyle: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
