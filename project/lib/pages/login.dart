import 'package:flutter/material.dart';

class IziGymLoginApp extends StatelessWidget {
  const IziGymLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IziGym Login',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema escuro como base
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black, // Fundo preto
        // Cor primária vermelha
        primarySwatch: Colors.red,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50000), // Vermelho principal
          secondary: Color(0xFFE50000),
          surface: Color(0xFF1C1C1C), // Cor de fundo dos campos de texto (cinza escuro)
        ),
        // Estilo para os campos de texto
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF1C1C1C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Color(0xFFE50000), width: 3.0),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        // Estilo para o botão principal
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE50000), // Vermelho
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            minimumSize: const Size(double.infinity, 50),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Para obter a largura da tela e ajustar o padding
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalPadding = screenWidth * 0.08;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Espaço no topo
              SizedBox(height: MediaQuery.of(context).padding.top + 40),

               // Logo IziGym
              Image.asset(
                'assets/logo.png',
                width: 250,
                height: 250,
                fit: BoxFit.contain,
              ),
              
              const SizedBox(height: 30),

              // Texto "Bem-vindo"
              const Text(
                'Bem-vindo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 30),

              // Campo de E-mail
              _buildTextField(
                hintText: 'E-mail',
                icon: Icons.alternate_email,
                isPassword: false,
              ),

              const SizedBox(height: 20),

              // Campo de Senha
              _buildTextField(
                hintText: 'Senha',
                icon: Icons.lock_outline,
                isPassword: true,
              ),

              const SizedBox(height: 30),

              // Botão Entrar
              ElevatedButton(
                onPressed: () {
                  // Ação de login
                },
                child: const Text('Entrar'),
              ),

              const SizedBox(height: 30),

              // Botão Entrar com Google
              _buildSocialButton(
                text: 'Entrar com Google',
                iconPath: 'assets/google_icon.png', // Placeholder
                backgroundColor: Colors.white,
                textColor: Colors.black,
                borderColor: Colors.white,
                onPressed: () {},
              ),

              const SizedBox(height: 15),

              // Botão Entrar com Facebook
              _buildSocialButton(
                text: 'Entrar com facebook',
                iconPath: 'assets/facebook_icon.png', // Placeholder
                backgroundColor: Colors.white,
                textColor: Colors.black,
                borderColor: Colors.white,
                onPressed: () {},
              ),

              const SizedBox(height: 40),

              // Links de Acesso
              const Text(
                'Primeiro acesso',
                style: TextStyle(
                  color: Colors.white,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Esqueceu a senha',
                style: TextStyle(
                  color: Color(0xFFE50000), // Vermelho
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFFE50000),
                  fontSize: 16,
                ),
              ),

              // Espaço no final para garantir scroll
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hintText,
    required IconData icon,
    required bool isPassword,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: const Color(0xFFE50000), width: 2.0),
      ),
      child: TextField(
        obscureText: isPassword,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Icon(icon, color: const Color(0xFFE50000)),
          ),
          // Remove a borda interna pois já temos o Container decorado
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 0.0),
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required String text,
    required String iconPath,
    required Color backgroundColor,
    required Color textColor,
    required Color borderColor,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        side: BorderSide(color: borderColor, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Placeholder para o ícone (O ideal seria usar um pacote como font_awesome_flutter ou ícones reais)
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                image: AssetImage(iconPath), // Isso falhará sem os assets, mas mostra a intenção
                fit: BoxFit.contain,
              ),
            ),
            child: iconPath.contains('google')
                ? Image.asset('assets/google_icon.png', height: 24) // Ícone Google (precisa de asset)
                : Image.asset('assets/facebook_icon.png', height: 24), // Ícone Facebook (precisa de asset)
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: textColor),
          ),
        ],
      ),
    );
  }
}
