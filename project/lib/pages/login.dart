import 'package:flutter/material.dart';
import 'ResetarSenhaPage.dart';
import 'CadastroPage.dart';
import 'HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Controladores para ler o que foi digitado nos campos
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _fazerLogin() {
    // Validação simples: verifica se os campos não estão vazios
    if (_emailController.text.isNotEmpty && _senhaController.text.isNotEmpty) {
      // pushReplacement: Troca a tela atual pela nova.
      // O usuário NÃO consegue voltar para o login apertando "voltar".
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // Mostra um aviso rodapé (SnackBar) se faltar dados
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Preencha e-mail e senha!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Layout básico com Padding para não colar nas bordas
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // Permite rolar se a tela for pequena
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo do app
              Image.asset(
                'assets/logo.png',
                height: 220,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.lock_reset, size: 100, color: Colors.red),
              ),
              const SizedBox(height: 30),
              const Text(
                'Bem-vindo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),

              // Campos de texto
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Color(0xFFE50000),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText: true, // Esconde a senha (bolinhas)
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFFE50000),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Botão Entrar
              ElevatedButton(
                onPressed: _fazerLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50000),
                  minimumSize: const Size(double.infinity, 50), // Largura total
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Entrar',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              // Links de texto (GestureDetector torna o texto clicável)
              GestureDetector(
                onTap: () {
                  // Navegação normal (push): O usuário pode voltar para o login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CadastroPage(),
                    ),
                  );
                },
                child: const Text(
                  'Primeiro acesso? Cadastre-se',
                  style: TextStyle(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ResetarSenhaPage(),
                    ),
                  );
                },
                child: const Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: Color(0xFFE50000)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
