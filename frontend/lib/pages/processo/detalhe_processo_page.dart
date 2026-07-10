import 'package:flutter/material.dart';

import '../../models/ativo_minerario.dart';
import '../../models/processo_minerario.dart';
import '../../services/processo_service.dart';

class DetalheProcessoPage extends StatefulWidget {
  final int idProcesso;

  const DetalheProcessoPage({
    super.key,
    required this.idProcesso,
  });

  @override
  State<DetalheProcessoPage> createState() => _DetalheProcessoPageState();
}

class _DetalheProcessoPageState extends State<DetalheProcessoPage> {

  ProcessoMinerario? processo;
  AtivoMinerario? ativo;

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    carregarDetalhes();
  }

  Future<void> carregarDetalhes() async {

    final resultado = await ProcessoService().buscarDetalhes(
      widget.idProcesso,
    );

    setState(() {
      processo = resultado["processo"];
      ativo = resultado["ativo"];

      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (carregando) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            Text(
              processo!.processo,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Text("Substância: ${processo!.subs}"),
            Text("Fase: ${processo!.fase}"),
            Text("Área: ${processo!.areaHa} ha"),

            const SizedBox(height: 30),

            if (ativo != null) ...[

              const Divider(),

              const SizedBox(height: 20),

              const Text(
                "Ativo Minerário",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "Descrição:\n${ativo!.descricao}",
              ),

              const SizedBox(height: 20),

              Text(
                "Titular: ${ativo!.usuario?.nome}",
              ),
            ]
          ],
        ),
      ),
    );
  }
}