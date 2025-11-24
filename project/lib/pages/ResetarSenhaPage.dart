import 'package:flutter/material.dart';
import 'TelaVerificacao.dart';

class ResetarSenhaPage extends StatefulWidget {
  const ResetarSenhaPage({super.key});

  @override
  State<ResetarSenhaPage> createState() => _ResetarSenhaPageState();
}

class _ResetarSenhaPageState extends State<ResetarSenhaPage> {
  // [4.2 Estado] Controller para capturar o que for digitado no campo de e-mail.
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // [4.5 Layout] Stack: Permite colocar widgets uns sobre os outros (ex: Botão voltar em cima do fundo).
      body: Stack(
        children: [
          // [4.5 Layout] SingleChildScrollView: Se o teclado subir, a tela rola e não quebra (overflow).
          SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 80), // Espaço no topo.
                // [Imagens] Exibição de logo com fallback de ícone em caso de erro.
                Image.asset(
                  'assets/logo.png',
                  height: 220,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.lock_reset,
                    size: 100,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 40),
                // [Texto] Título estilizado manualmente.
                const Text(
                  'Redefinir Senha',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 60),

                // [4.4 Formulários] Campo de e-mail.
                TextField(
                  controller: _emailController, // Vínculo com o controller.
                  style: const TextStyle(
                    color: Colors.white,
                  ), // Cor do texto digitado.
                  decoration: const InputDecoration(
                    hintText: 'E-mail', // Placeholder.
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      color: Color(0xFFE50000),
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // [Botão de Ação]
                ElevatedButton(
                  onPressed: () {
                    // [4.4 Formulários] Validação simples:
                    // Verifica se o campo não está vazio antes de prosseguir.
                    if (_emailController.text.isNotEmpty) {
                      print("Código enviado para ${_emailController.text}");

                      // [4.1 Navegação] Navigator.push:
                      // Empilha a próxima tela (TelaVerificacao) sobre esta.
                      // O usuário poderá voltar clicando no botão de voltar.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaVerificacao(),
                        ),
                      );
                    } else {
                      // [4.8 Feedback] SnackBar:
                      // Exibe erro se o campo estiver vazio.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Digite seu email")),
                      );
                    }
                  },
                  // [Estilo] Botão vermelho arredondado.
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE50000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // [4.5 Layout] Positioned:
          // Funciona APENAS dentro de uma Stack. Posiciona o botão voltar no topo esquerdo.
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              // [4.1 Navegação] Navigator.pop:
              // Remove a tela atual da pilha e volta para a tela anterior (Login provavelmente).
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
