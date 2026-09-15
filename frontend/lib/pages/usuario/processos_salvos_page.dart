import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/favorito_viewmodel.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';
import 'package:provider/provider.dart';

import '../../widgets/cards/card_processo_minerario.dart';
import '../processo/detalhe_processo_page.dart';

class ProcessosSalvosPage extends StatefulWidget {
  const ProcessosSalvosPage({super.key});

  @override
  State<ProcessosSalvosPage> createState() => _ProcessosSalvosPageState();
}

class _ProcessosSalvosPageState extends State<ProcessosSalvosPage> {
  TextEditingController controllerPesquisar = TextEditingController();
  String pesquisa = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<FavoritoViewModel>(
        context,
        listen: false,
      ).carregarFavoritos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritoViewModel>(context);

    final favoritosFiltrados = provider.favoritos.where((favorito) {
      final processo = favorito.processo;

      return processo.processo.toLowerCase().contains(pesquisa) ||
          processo.nome.toLowerCase().contains(pesquisa) ||
          processo.subs.toLowerCase().contains(pesquisa) ||
          processo.fase.toLowerCase().contains(pesquisa);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE0E0E0), width: 2),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(0xFF848484),
              ),
            ),
          ),
        ),
      ),

      body: provider.carregando
          ? const Center(child: CircularProgressIndicator())
          : provider.favoritos.isEmpty
          ? const Center(child: Text("Você ainda não salvou nenhum processo."))
          : Padding(
              padding: const EdgeInsetsGeometry.all(24.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Processos Salvos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A81FA),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  PesquisarInput(
                    controller: controllerPesquisar,
                    onChanged: (valor) {
                      setState(() {
                        pesquisa = valor.toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: ListView.builder(
                      itemCount: favoritosFiltrados.length,

                      itemBuilder: (context, index) {
                        final favorito = favoritosFiltrados[index];

                        return CardProcessoMinerario(
                          processo: favorito.processo,

                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => DetalheProcessoPage(
                                  idProcesso: favorito.processo.idProcesso,
                                ),
                              ),
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
