import 'package:flutter/material.dart';
import 'package:project/models/exercicio.dart';

class DetalheExercicioPage extends StatefulWidget {
  final Exercicio exercicio;

  const DetalheExercicioPage({super.key, required this.exercicio});

  @override
  State<DetalheExercicioPage> createState() => _DetalheExercicioPageState();
}

class _DetalheExercicioPageState extends State<DetalheExercicioPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // App Bar customizada transparente para o botão "Cancelar"
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: TextButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          label: Text("Voltar", style: TextStyle(color: Colors.black)),
        ),
        leadingWidth: 100,
      ),
      body: Column(
        children: [
          // 1. Área do GIF/Imagem
          Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey[900],
            child: widget.exercicio.gifUrl.isNotEmpty
                ? Image.network(
                    widget.exercicio.gifUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.white54,
                    ),
                  )
                : Icon(Icons.movie, size: 80, color: Colors.white24),
          ),

          // 2. Nome do Exercício
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFF1C1C1C),
            child: Text(
              widget.exercicio.nome,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // 3. Abas (Instruções / Detalhes)
          Container(
            color: Color(0xFF1C1C1C),
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.red,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(text: "Instruções"),
                Tab(text: "Dica de Execução"),
              ],
            ),
          ),

          // 4. Conteúdo das Abas
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Aba 1: Instruções (Conteúdo dinâmico do JSON)
                _buildInstrucoesTab(),
                // Aba 2: dicas (Placeholder por enquanto)
                Center(
                  child: Text(
                    "Dicas e erros comuns virão aqui!",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInstrucoesTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle("Descrição"),
          Text(
            widget.exercicio.descricao,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
          SizedBox(height: 20),

          _buildSectionTitle("Músculos Alvo"),
          Wrap(
            spacing: 8,
            children: widget.exercicio.musculosAlvo
                .map(
                  (musculo) => Chip(
                    backgroundColor: Color(0xFFE50000),
                    label: Text(musculo, style: TextStyle(color: Colors.white)),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
