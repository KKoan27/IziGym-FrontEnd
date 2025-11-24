import 'package:flutter/material.dart';
import 'NovaSenhaPage.dart'; // Importa a próxima tela do fluxo.

class TelaVerificacao extends StatefulWidget {
  const TelaVerificacao({super.key});

  @override
  State<TelaVerificacao> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<TelaVerificacao> {
  // [4.5.1 Widgets] FocusNode:
  // Objetos que controlam onde o cursor do teclado está. Necessário para pular de caixinha em caixinha.
  late List<FocusNode> _focusNodes;
  // [4.2 Estado] Lista de controllers, um para cada dígito do código.
  late List<TextEditingController> _controllers;

  // [4.2 Estado / Ciclo de Vida] initState:
  // Executado UMA vez quando a tela é criada. Ideal para inicializar listas e listeners.
  @override
  void initState() {
    super.initState();
    // [4.5 Listas] Gera 4 FocusNodes e 4 Controllers dinamicamente.
    _focusNodes = List.generate(4, (index) => FocusNode());
    _controllers = List.generate(4, (index) => TextEditingController());
  }

  // [7 Boas práticas] dispose:
  // Executado quando a tela é destruída. OBRIGATÓRIO dar dispose em controllers e focusNodes
  // para não travar o app (memory leak).
  @override
  void dispose() {
    for (var node in _focusNodes) node.dispose();
    for (var controller in _controllers) controller.dispose();
    super.dispose();
  }

  // [Lógica Personalizada] Função que detecta digitação e move o foco.
  void _nextField(String value, int index) {
    // Se digitou 1 caractere e não é o último campo, vai para o próximo.
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    // Se apagou (vazio) e não é o primeiro campo, volta para o anterior.
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                const SizedBox(height: 80),
                Image.asset(
                  'assets/logo.png',
                  height: 220,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.security, size: 100, color: Colors.red),
                ),
                const SizedBox(height: 40),
                const Text(
                  'Insira o código de\nverificação:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 60),

                // [4.5 Layout] Row: Alinha os 4 campos horizontalmente.
                Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceEvenly, // Espaçamento igual entre eles.
                  // [4.5 Listas] List.generate:
                  // Cria os 4 campos de texto automaticamente baseado no índice (0 a 3).
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 60, // Largura fixa para cada caixinha.
                      child: TextField(
                        controller:
                            _controllers[index], // Pega o controller correspondente ao índice.
                        focusNode:
                            _focusNodes[index], // Pega o foco correspondente.
                        textAlign: TextAlign.center, // Texto no meio da caixa.
                        keyboardType: TextInputType.number, // Teclado numérico.
                        maxLength: 1, // Só aceita 1 número por caixa.
                        // [4.3 Interação] onChanged: Chama a função de mudar foco ao digitar.
                        onChanged: (value) => _nextField(value, index),
                        style: const TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        // [4.4 Formulários] Decoração minimalista (apenas uma linha embaixo).
                        decoration: const InputDecoration(
                          counterText: "", // Esconde o contador "0/1".
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 2,
                            ),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(
                                0xFFE50000,
                              ), // Muda cor quando focado.
                              width: 2,
                            ),
                          ),
                          fillColor: Colors.transparent,
                        ),
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 30),

                // [4.3 Gestos] GestureDetector:
                // Torna o texto "Reenviar código" clicável (o Text widget não tem clique nativo).
                GestureDetector(
                  onTap: () {
                    // [4.8 Feedback] SnackBar simulando o reenvio.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Código reenviado!")),
                    );
                  },
                  child: const Text(
                    'Reenviar código',
                    style: TextStyle(
                      color: Colors.white54,
                      decoration: TextDecoration
                          .underline, // Sublinhado para parecer link.
                      fontSize: 14,
                    ),
                  ),
                ),

                const SizedBox(height: 60),

                // [Botão Validar]
                ElevatedButton(
                  onPressed: () {
                    // [Lógica] Recupera os textos dos 4 controllers e junta numa String só.
                    String code = _controllers.map((c) => c.text).join();
                    print("Código digitado: $code");

                    // [4.1 Navegação] Vai para a tela final (NovaSenhaPage).
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NovaSenhaPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE50000),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Validar',
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
          // [Botão Voltar Flutuante]
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () =>
                  Navigator.pop(context), // Volta para ResetarSenhaPage.
            ),
          ),
        ],
      ),
    );
  }
}
