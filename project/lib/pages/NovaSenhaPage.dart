// [Importação] Pacote base de UI do Flutter (Widgets, Material Design).
import 'package:flutter/material.dart';
// [Importação] Importa a tela de Login para onde navegaremos ao final.
import 'login.dart';

// [Estrutura] StatefulWidget é necessário pois temos campos de texto que mudam (Estado).
class NovaSenhaPage extends StatefulWidget {
  // [Boas Práticas] Construtor constante para otimização.
  const NovaSenhaPage({super.key});

  @override
  State<NovaSenhaPage> createState() => _NovaSenhaPageState();
}

class _NovaSenhaPageState extends State<NovaSenhaPage> {
  // [4.2 Estado e reatividade] & [4.4 Formulários]
  // Controllers são essenciais para ler o texto digitado e limpar campos se necessário.
  final _senhaController = TextEditingController();
  final _confirmaController = TextEditingController();

  // [7 Boas Práticas] O método dispose (não incluído aqui, mas recomendado)
  // deveria descartar os controllers para evitar vazamento de memória.

  @override
  Widget build(BuildContext context) {
    // [4.5.1 Widgets chave] Scaffold: O esqueleto padrão da tela.
    return Scaffold(
      // [4.5 Layout] AppBar transparente para dar um efeito visual moderno.
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Remove cor de fundo.
        elevation: 0, // Remove a sombra.
        title: const Text("Nova Senha"), // Título da tela.
      ),
      // [4.5 Layout] Padding dá respiro nas bordas para o conteúdo não colar na tela.
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        // [4.5 Layout] Column: Organiza os filhos um abaixo do outro (verticalmente).
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza verticalmente.
          children: [
            // [4.5.1 Widgets] Exibe uma imagem dos assets.
            Image.asset(
              'assets/logo.png',
              height: 220,
              // [7 Boas Práticas] errorBuilder evita crash se a imagem não carregar.
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
            // [4.5 Layout] SizedBox cria um espaço vazio vertical de 40px.
            const SizedBox(height: 40),

            // [Texto] Título informativo.
            const Text(
              "Crie uma nova senha",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 30),

            // [4.4 Formulários] TextField: Onde o usuário digita.
            TextField(
              controller:
                  _senhaController, // Liga o input à variável de controle.
              // [4.4 Formulários] obscureText: true transforma texto em bolinhas (senha).
              obscureText: true,
              // [4.8 Temas/estilo] InputDecoration define ícones, labels e bordas.
              decoration: const InputDecoration(
                labelText: "Nova Senha",
                prefixIcon: Icon(Icons.lock, color: Color(0xFFE50000)),
              ),
            ),
            const SizedBox(height: 20),

            // [4.4 Formulários] Segundo campo para confirmação de senha.
            TextField(
              controller: _confirmaController,
              obscureText: true, // Também esconde o texto.
              decoration: const InputDecoration(
                labelText: "Confirmar Senha",
                prefixIcon: Icon(Icons.lock_outline, color: Color(0xFFE50000)),
              ),
            ),
            const SizedBox(height: 40),

            // [4.5.1 Widgets] Botão elevado (com fundo preenchido).
            ElevatedButton(
              onPressed: () {
                // [4.1 Navegação] pushAndRemoveUntil: CRUCIAL PARA A PROVA.
                // Remove TODAS as rotas anteriores da pilha. O usuário não pode voltar
                // para a tela de "Nova Senha" apertando "Voltar" depois de logar.
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false, // Predicado 'false' remove tudo.
                );

                // [4.3 Gestos / 4.8 Feedback] SnackBar avisa que deu tudo certo.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Senha alterada com sucesso!")),
                );
              },
              // [4.8 Temas/estilo] Estilização específica deste botão.
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(
                  0xFFE50000,
                ), // Cor personalizada (Vermelho).
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ), // Bordas arredondadas.
                ),
                minimumSize: const Size(double.infinity, 50), // Largura total.
              ),
              child: const Text(
                "Redefinir Senha",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}  //// ... dentro do children da Column ...


