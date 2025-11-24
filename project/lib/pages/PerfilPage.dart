import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  // Controladores
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _alturaController = TextEditingController();
  final TextEditingController _pesoController = TextEditingController();

  double _imc = 0.0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosDoStorage();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _idadeController.dispose();
    _alturaController.dispose();
    _pesoController.dispose();
    super.dispose();
  }

  // --- LÓGICA DO SHARED PREFERENCES ---

  // 1. Carregar dados salvos pelo Login
  Future<void> _carregarDadosDoStorage() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // O '??' garante que se não houver dados, não quebra (usa string vazia)
      // Certifique-se que seu amigo use ESSAS MESMAS CHAVES ('user_nome', 'user_email', etc)
      _nomeController.text = prefs.getString('user_nome') ?? '';
      _emailController.text = prefs.getString('user_email') ?? '';

      // Idade
      int idade = prefs.getInt('user_idade') ?? 0;
      _idadeController.text = idade > 0 ? idade.toString() : '';

      // Altura e Peso (Double)
      double altura = prefs.getDouble('user_altura') ?? 0.0;
      double peso = prefs.getDouble('user_peso') ?? 0.0;

      _alturaController.text = altura > 0 ? altura.toString() : '';
      _pesoController.text = peso > 0 ? peso.toString() : '';

      _isLoading = false;
    });
  }

  // 2. Salvar dados atualizados (opcional, caso o usuário edite o perfil aqui)
  Future<void> _salvarDadosNoStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // Salva as strings
    await prefs.setString('user_nome', _nomeController.text);
    // Email geralmente não se edita fácil, mas se quiser salvar:
    // await prefs.setString('user_email', _emailController.text);

    // Converte e salva números
    int? idade = int.tryParse(_idadeController.text);
    if (idade != null) await prefs.setInt('user_idade', idade);

    double? peso = double.tryParse(_pesoController.text);
    if (peso != null) await prefs.setDouble('user_peso', peso);

    double? altura = double.tryParse(_alturaController.text);
    if (altura != null) await prefs.setDouble('user_altura', altura);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Perfil atualizado no dispositivo!"),
          backgroundColor: Color(0xFFE50000),
        ),
      );
    }
  }

  // --- FIM DA LÓGICA DO STORAGE ---

  void _calcularIMC() {
    FocusScope.of(context).unfocus(); // Fecha teclado

    double alturaCm = double.tryParse(_alturaController.text) ?? 0;
    double peso = double.tryParse(_pesoController.text) ?? 0;

    if (alturaCm > 0 && peso > 0) {
      setState(() {
        double alturaMetros = alturaCm / 100;
        _imc = peso / (alturaMetros * alturaMetros);
      });
      // Opcional: Salvar automaticamente ao calcular
      _salvarDadosNoStorage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Preencha peso e altura corretamente!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: CircularProgressIndicator(color: Color(0xFFE50000)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Meu Perfil", style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Color(0xFFE50000)),
            onPressed: _salvarDadosNoStorage,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CABEÇALHO
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: Color(0xFFE50000),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _nomeController.text.isNotEmpty
                            ? _nomeController.text
                            : "Usuário",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _emailController.text,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // SEÇÃO DADOS PESSOAIS
              _buildSectionHeader("Dados Pessoais"),
              const SizedBox(height: 10),
              _buildInputRow("Nome", _nomeController),
              // Email em modo somente leitura (readOnly: true) pois geralmente vem do login
              _buildInputRow("Email", _emailController, readOnly: true),
              _buildInputRow("Idade", _idadeController, isNumber: true),

              const SizedBox(height: 20),

              // SEÇÃO MEDIDAS CORPORAIS
              _buildSectionHeader("Medidas Corporais"),
              const SizedBox(height: 10),
              _buildInputRow(
                "Altura",
                _alturaController,
                suffix: "cm",
                isNumber: true,
              ),
              _buildInputRow(
                "Peso",
                _pesoController,
                suffix: "kg",
                isNumber: true,
              ),

              const SizedBox(height: 20),

              // BOTÃO CALCULAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE50000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _calcularIMC,
                    child: const Text(
                      "CALCULAR IMC",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // RESULTADO IMC
              if (_imc > 0) ...[
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  color: const Color(0xFF1C1C1C),
                  child: const Text(
                    "Resultado",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE50000),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "SEU IMC",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              _imc.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Text(
                          _interpretarIMC(_imc),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              // TABELA
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Divider(color: Colors.grey),
                    _buildIMCTableRow("IMC", "Classificação", isHeader: true),
                    const Divider(color: Color(0xFFE50000)),
                    _buildIMCTableRow("< 18.5", "Magreza"),
                    _buildIMCTableRow("18.5 - 24.9", "Normal"),
                    _buildIMCTableRow("25.0 - 29.9", "Sobrepeso"),
                    _buildIMCTableRow("30.0 - 39.9", "Obesidade"),
                    _buildIMCTableRow("> 40.0", "Obesidade Grave"),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // MÉTODOS AUXILIARES E WIDGETS (Mesmo design anterior)
  String _interpretarIMC(double imc) {
    if (imc < 18.5) return "Abaixo do peso.";
    if (imc < 24.9) return "Peso normal.";
    if (imc < 29.9) return "Sobrepeso.";
    if (imc < 39.9) return "Obesidade.";
    return "Obesidade Grave.";
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      color: const Color(0xFF1C1C1C),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInputRow(
    String label,
    TextEditingController controller, {
    String suffix = "",
    bool isNumber = false,
    bool readOnly = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 45,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xFF1C1C1C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
            child: Text(label, style: const TextStyle(color: Colors.white)),
          ),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: readOnly
                    ? Colors.grey[300]
                    : Colors.white, // Visual diferente se for ReadOnly
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: TextField(
                controller: controller,
                readOnly: readOnly, // Bloqueia edição se necessário
                keyboardType: isNumber
                    ? const TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
                inputFormatters: isNumber
                    ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
                    : [],
                style: TextStyle(
                  color: readOnly ? Colors.black54 : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 11,
                  ),
                  suffixText: suffix.isNotEmpty ? "$suffix   " : null,
                  suffixStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIMCTableRow(String col1, String col2, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            col1,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            col2,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
