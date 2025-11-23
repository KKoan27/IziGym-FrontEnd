import 'package:flutter/material.dart';

class Treino {
  final String titulo;
  final String nome;
  final String detalhes;

  Treino(this.titulo, this.nome, this.detalhes);
}

class TreinoPage extends StatefulWidget {
  const TreinoPage({super.key});

  @override
  State<TreinoPage> createState() => _TreinoPageState();
}

class _TreinoPageState extends State<TreinoPage> {
  List<Treino> treinos = [
    Treino("Treino A", "Nome do treino", "Exemplo: 5 exercícios • Foco: Hipertrofia"),
    Treino("Treino B", "Pernas", "Exemplo: 7 exercícios • Foco: Força"),
    Treino("Treino C", "Costas", "Exemplo: 6 exercícios • Foco: Resistência"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Meus Treinos")),

      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: treinos.length,
        itemBuilder: (context, index) {
          final treino = treinos[index];

          return Card(
            elevation: 4,
            margin: EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    treino.titulo,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    treino.nome,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(height: 8),
                  Text(
                    treino.detalhes,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.playlist_add_rounded),
        onPressed: () {
          Navigator.pushNamed(context, '/addtreino');
        },
      ),
    );
  }
}



//  PRIMEIRO CÓDIGO FEITO //

// import 'package:flutter/material.dart';

// class TreinoPage extends StatefulWidget {
//   const TreinoPage({super.key});

//   @override
//   State<TreinoPage> createState() => _TreinoPageState();
// }

// class _TreinoPageState extends State<TreinoPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Meus Treinos"),
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: [
//             Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Treino A",
//                       style: TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       "Nome do treino",
//                       style: TextStyle(
//                         fontSize: 15,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       "Exemplo: 5 exercícios · Foco: Hipertrofia",
//                       style: TextStyle(
//                         fontSize: 13,
//                         color: Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.playlist_add_rounded),
//         onPressed: () {
//           Navigator.pushNamed(context, '/addtreino');
//         },
//       ),
//     );
//   }
// }
