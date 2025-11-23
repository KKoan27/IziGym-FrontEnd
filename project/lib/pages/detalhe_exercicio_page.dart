import 'package:flutter/material.dart';
import 'package:project/models/exercicio.dart';

class DetalheExercicioPage extends StatefulWidget {
  final Exercicio exercicio;

  const DetalheExercicioPage({super.key, required this.exercicio});

  @override
  State<DetalheExercicioPage> createState() => _DetalheExercicioPageState();
}

class _DetalheExercicioPageState extends State<DetalheExercicioPage> {
  // 0 = Instruções, 1 = Detalhes
  int _abaSelecionada = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Cabeçalho: Botão Cancelar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          "Cancelar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // 2. Título do Exercício
            Text(
              widget.exercicio.nome,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            // 3. Imagem / GIF Centralizado
            SizedBox(
              height: 250, // Altura ajustada para o layout
              child: widget.exercicio.gifUrl.isNotEmpty
                  ? Image.network(
                      widget.exercicio.gifUrl,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 80,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(Icons.movie, size: 80, color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // 4. Abas Customizadas (Botões Sólidos)
            Row(
              children: [
                _buildCustomTab("Instruções", 0),
                _buildCustomTab("Detalhes", 1),
              ],
            ),

            // 5. Conteúdo da Aba Selecionada
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.black,
                child: SingleChildScrollView(
                  child: _abaSelecionada == 0
                      ? _buildInstrucoesContent()
                      : _buildDetalhesContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget para criar os botões das abas (Vermelho se ativo, Cinza se inativo)
  Widget _buildCustomTab(String title, int index) {
    final bool isActive = _abaSelecionada == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _abaSelecionada = index;
          });
        },
        child: Container(
          height: 50,
          alignment: Alignment.center,
          color: isActive
              ? const Color(0xFFE50000) // Vermelho Ativo
              : const Color(0xFF1C1C1C), // Cinza Inativo
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInstrucoesContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(
        20,
      ), // Padding geral para não colar nas bordas
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- 1. SEÇÃO MÚSCULOS (Estilo Minimalista) ---
          const Text(
            "Músculo Principal (Foco)",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...widget.exercicio.musculosAlvo.map(
            (musculo) => Padding(
              padding: const EdgeInsets.only(bottom: 6.0, left: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("• ", style: TextStyle(color: Colors.white)),
                  Expanded(
                    child: Text(
                      musculo,
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // --- 2. SEÇÃO EXECUÇÃO ---
          const Text(
            "Execução",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            widget.exercicio.descricao,
            style: const TextStyle(color: Colors.white70, height: 1.4),
          ),

          const SizedBox(height: 20),

          // --- 3. SEÇÃO DICAS (Novo, mantendo o estilo minimalista) ---
        ],
      ),
    );
  }

  Widget _buildDetalhesContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.exercicio.dicas.isNotEmpty) ...[
            const Text(
              "Dicas e Erros Comuns",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...widget.exercicio.dicas.map(
              (dica) => Padding(
                padding: const EdgeInsets.only(bottom: 6.0, left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // O mesmo bullet simples "• " usado nos músculos
                    const Text("• ", style: TextStyle(color: Colors.white)),
                    Expanded(
                      child: Text(
                        dica,
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            // Caso a lista de dicas esteja vazia (opcional)
            const Text(
              "Nenhuma informação adicional disponível.",
              style: TextStyle(color: Colors.white38),
            ),
          ],
        ],
      ),
    );
  }
}
