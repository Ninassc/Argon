import 'package:flutter/material.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';

import '../../models/favorito.dart';
import '../../services/favorito_service.dart';
import '../../widgets/cards/card_processo_minerario.dart';
import '../processo/detalhe_processo_page.dart';

class ProcessosSalvosPage extends StatefulWidget {
  const ProcessosSalvosPage({super.key});

  @override
  State<ProcessosSalvosPage> createState() => _ProcessosSalvosPageState();
}

class _ProcessosSalvosPageState extends State<ProcessosSalvosPage> {
  List<Favorito> favoritos = [];
  TextEditingController controllerPesquisar = TextEditingController();
  String pesquisa = "";

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    carregarFavoritos();
  }

  Future<void> carregarFavoritos() async {
    final resultado = await FavoritoService().listar();

    if (!mounted) return;

    setState(() {
      favoritos = resultado;
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    final favoritosFiltrados = favoritos.where((favorito) {
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

      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : favoritos.isEmpty
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
