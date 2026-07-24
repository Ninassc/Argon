import 'package:flutter/material.dart';
import 'package:frontend/services/processo_service.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';

class SelecionarSubstanciaBottomSheet extends StatefulWidget {
  const SelecionarSubstanciaBottomSheet({super.key});

  @override
  State<SelecionarSubstanciaBottomSheet> createState() =>
      _SelecionarSubstanciaBottomSheetState();
}

class _SelecionarSubstanciaBottomSheetState
    extends State<SelecionarSubstanciaBottomSheet> {
  late Future<List<String>> futureSubstancias;

  List<String> todas = [];
  List<String> filtradas = [];

  final controllerPesquisa = TextEditingController();

  @override
  void initState() {
    super.initState();

    futureSubstancias = carregar();
  }

  @override
  void dispose() {
    controllerPesquisa.dispose();
    super.dispose();
  }

  Future<List<String>> carregar() async {
    final lista = await ProcessoService().listarSubstancias();

    todas = lista;
    filtradas = lista;

    return lista;
  }

  void pesquisar(String texto) {
    setState(() {
      filtradas = todas.where((item) {
        return item.toLowerCase().contains(texto.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.85,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Selecionar substância",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5A81FA),
              ),
            ),

            const SizedBox(height: 20),

            PesquisarInput(
              controller: controllerPesquisa,
              onChanged: pesquisar,
            ),

            const SizedBox(height: 20),

            Expanded(
              child: FutureBuilder<List<String>>(
                future: futureSubstancias,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text("Erro ao carregar substâncias."),
                    );
                  }

                  return ListView.builder(
                    itemCount: filtradas.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return ListTile(
                          title: const Text("Todas"),
                          onTap: () {
                            Navigator.pop(context, "Todas");
                          },
                        );
                      }

                      final substancia = filtradas[index - 1];

                      return ListTile(
                        title: Text(substancia, style: TextStyle(
                          fontSize: 16
                        ),),
                        onTap: () {
                          Navigator.pop(context, substancia);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
