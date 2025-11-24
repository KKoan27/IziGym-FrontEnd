import 'package:flutter/material.dart';
import 'ResetarSenhaPage.dart';
import 'CadastroPage.dart';
import 'HomePage.dart';

// [4.2 Estado] StatefulWidget é necessário pois temos controllers e o estado da tela pode mudar (ex: validar campos).
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // [4.4 Formulários] Controladores: Essenciais para ler e limpar o texto dos TextFields.
  // Mantenha-os 'final' se não for reatribuir a variável.
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();

  void _fazerLogin() {
    // [4.4 Formulários] Validação básica manual (verifica se string não é vazia).
    if (_emailController.text.isNotEmpty && _senhaController.text.isNotEmpty) {
      // [4.1 Navegação] PushReplacement: IMPORTANTE PARA PROVA.
      // Destrói a tela de Login e coloca a Home no lugar.
      // Isso impede que o botão "Voltar" (Back) retorne para o login.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      // [4.8 Feedback] SnackBar: Aviso visual rápido exigido no ponto 4.3 e 4.8.
      // ScaffoldMessenger é a forma correta de chamar SnackBars nas versões novas do Flutter.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Preencha e-mail e senha!")));
    }
  }

  @override
  Widget build(BuildContext context) {
    // [4.5 Layout] Scaffold fornece a estrutura padrão (appBar, body, etc).
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          // [4.5 Layout] SingleChildScrollView com Padding evita erro de pixel overflow
          // quando o teclado sobe em telas pequenas.
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo do app
              Image.asset(
                'assets/logo.png',
                height: 220,
                // Tratamento de erro caso a imagem não carregue (Boa prática).
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

              // [4.4 Formulários] TextField conectado ao controller.
              TextField(
                controller: _emailController, // Liga o input à variável
                decoration: const InputDecoration(
                  hintText: 'E-mail',
                  // Estilização com ícones (4.8 Temas/estilo).
                  prefixIcon: Icon(
                    Icons.alternate_email,
                    color: Color(0xFFE50000),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _senhaController,
                obscureText:
                    true, // [4.4] Propriedade essencial para senhas (bolinhas).
                decoration: const InputDecoration(
                  hintText: 'Senha',
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Color(0xFFE50000),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // [4.3 Interação] Botão principal.
              ElevatedButton(
                onPressed: _fazerLogin, // Chama a função criada acima.
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50000), // Cor personalizada
                  minimumSize: const Size(
                    double.infinity,
                    50,
                  ), // Largura total (Expanded/Stretch)
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

              // [4.3 Gestos] GestureDetector: Transforma qualquer widget (Text, Container, Image) em um botão.
              // Ponto essencial da prova sobre "Adicionar gesto em widget específico".
              GestureDetector(
                onTap: () {
                  // [4.1 Navegação] Navigator.push: Empilha a tela nova.
                  // O botão "Voltar" funcionará para retornar ao Login.
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
