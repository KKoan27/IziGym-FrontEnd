import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdicionaExercicio extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AdicionaExercicioState();
}

class AdicionaExercicioState extends State<AdicionaExercicio> {
  late Future<List<Map<String, dynamic>>> exercicioFuture;
  List<int> selectedIndex = [];
  List<Map<String, dynamic>> bodySelect = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: exercicioFuture,
              builder: (context, snapshot) {
                try {
                  if (snapshot.hasError) {
                    return Center(child: Text("Deu erro na requisição"));
                  }
                  // if (snapshot.connectionState == ConnectionState.waiting) {}
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var musculosAlvo = snapshot.data![index]['musculosAlvo']
                            .map((i) => i as String)
                            .join(',');

                        final bool selecionado = selectedIndex.contains(index);

                        return Card(
                          elevation: 3,
                          color: selecionado ? Colors.blue[700] : Colors.red,
                          margin: EdgeInsets.all(10),

                          child: CheckboxListTile(
                            title: Text(snapshot.data![index]['nome'] ?? ''),
                            subtitle: Text(musculosAlvo),

                            value: selecionado,
                            onChanged: (value) {
                              setState(() {
                                if (selecionado) {
                                  selectedIndex.remove(index);
                                  bodySelect.remove(snapshot.data![index]);
                                } else {
                                  selectedIndex.add(index);
                                  bodySelect.add(snapshot.data![index]);
                                }
                              });
                            },
                          ),
                        );
                      },
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                } on Exception catch (e) {
                  rethrow;
                }
              },
            ),
          ),
          ElevatedButton(
            onPressed: (() => Navigator.pop(context, bodySelect)),
            child: Text("Add"),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    exercicioFuture = getExercicios();
    super.initState();
  }

  Future<List<Map<String, dynamic>>> getExercicios() async {
    var response = await http.get(
      Uri.parse('https://izigym-backend.globeapp.dev/getexercicios'),
    );

    var responseJson = await jsonDecode(response.body) as Map<String, dynamic>;

    var responsebody = responseJson['response'] as List<dynamic>;

    return responsebody.map((i) => i as Map<String, dynamic>).toList();
  }
}
