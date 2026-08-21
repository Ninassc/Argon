import 'package:flutter/material.dart';
import 'package:frontend/models/compartilhamento_processo.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/services/compartilhamento_processo_service.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';

class CompartilhamentosEnviadosTab extends StatefulWidget {
  const CompartilhamentosEnviadosTab({super.key});

  @override
  State<CompartilhamentosEnviadosTab> createState() =>
      _CompartilhamentosEnviadosTabState();
}

class _CompartilhamentosEnviadosTabState
    extends State<CompartilhamentosEnviadosTab> {
  bool carregando = true;

  List<CompartilhamentoProcesso> compartilhamentos = [];

  @override
  void initState() {
    super.initState();

    carregar();
  }

  Future<void> carregar() async {
    try {
      final resultado = await CompartilhamentoProcessoService()
          .listarEnviados();

      if (!mounted) return;

      setState(() {
        compartilhamentos = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        carregando = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (compartilhamentos.isEmpty) {
      return const Center(
        child: Text("Você ainda não compartilhou nenhum processo."),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: compartilhamentos.length,
      itemBuilder: (context, index) {
        final compartilhamento = compartilhamentos[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Compartilhado com ${compartilhamento.usuarioDestino.nome}",
              style: const TextStyle(color: Color(0xFF848484)),
            ),

            const SizedBox(height: 6),

            CardProcessoMinerario(
              processo: compartilhamento.processo,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetalheProcessoPage(
                      idProcesso: compartilhamento.processo.idProcesso,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 15),
          ],
        );
      },
    );
  }
}
