import 'package:flutter/material.dart';
import 'HomePage.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  // [4.4] Criação de múltiplos controladores para o formulário extenso.
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final _confirmaSenhaController = TextEditingController();

  void _realizarCadastro() {
    // [4.4 Validação] Lógica simples exigida: Comparar valor de dois inputs.
    if (_senhaController.text != _confirmaSenhaController.text) {
      // [4.8] Feedback de erro.
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("As senhas não coincidem!")));
      return; // Para a execução aqui se der erro.
    }

    // Aqui entraria o [4.7 Consumo de API - POST] se fosse cobrado o envio real.
    print("Cadastrando: ${_nomeController.text}, ${_emailController.text}");

    // [4.1 Navegação Avançada] pushAndRemoveUntil:
    // Remove TODAS as telas anteriores (Login, Cadastro) e deixa só a Home.
    // Útil para quando o usuário loga/cadastra e não deve "deslogar" ao voltar.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
      (route) => false, // A condição 'false' mata todas as rotas anteriores.
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar transparente
        elevation: 0,
        // [4.1] Navigator.pop: Botão manual para voltar para tela anterior.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // [4.5 Layout] Stack não está sendo usado como Stack real aqui (só tem um filho body),
      // mas é útil se você quisesse colocar uma imagem de fundo fixa atrás.
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Image.asset(
                'assets/logo.png',
                height: 220,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.person_add, size: 80, color: Colors.red),
              ),
              const SizedBox(height: 30),
              const Text(
                'Cadastre-se',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // [7. Boas práticas] Uso de método helper (_buildInput) para evitar repetição de código (DRY).
              // Isso mostra organização para o professor.
              _buildInput(
                controller: _nomeController,
                label: "Nome completo",
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildInput(
                controller: _emailController,
                label: "E-mail",
                icon: Icons.alternate_email,
              ),
              const SizedBox(height: 15),
              _buildInput(
                controller: _senhaController,
                label: "Senha",
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              _buildInput(
                controller: _confirmaSenhaController,
                label: "Senha novamente",
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _realizarCadastro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE50000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  'Cadastrar',
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
      ),
    );
  }

  // Método auxiliar para criar TextFields padronizados.
  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFFE50000)),
      ),
    );
  }
}
