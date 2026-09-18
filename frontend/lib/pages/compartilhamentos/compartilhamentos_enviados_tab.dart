import 'package:flutter/material.dart';
import 'package:frontend/models/compartilhamento_processo.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/viewmodels/compartilhamento_processo_viewmodel.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';
import 'package:provider/provider.dart';

class CompartilhamentosEnviadosTab extends StatefulWidget {
  const CompartilhamentosEnviadosTab({super.key});

  @override
  State<CompartilhamentosEnviadosTab> createState() =>
      _CompartilhamentosEnviadosTabState();
}

class _CompartilhamentosEnviadosTabState
    extends State<CompartilhamentosEnviadosTab> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CompartilhamentoProcessoViewmodel>(
        context,
        listen: false,
      ).carregarEnviados();
    });
  }

  @override
  Widget build(BuildContext context) {
    final compartilhamentoProcessoViewmodel =
        Provider.of<CompartilhamentoProcessoViewmodel>(context);

    List<CompartilhamentoProcesso> compartilhamentos =
        compartilhamentoProcessoViewmodel.enviados;

    if (compartilhamentoProcessoViewmodel.carregandoEnviados) {
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
