import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/viewmodels/processo_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../models/processo_minerario.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/textfields/campo_input.dart';

class PesquisarProcessoAtivoPage extends StatefulWidget {
  const PesquisarProcessoAtivoPage({super.key});

  @override
  State<PesquisarProcessoAtivoPage> createState() =>
      _PesquisarProcessoAtivoPageState();
}

class _PesquisarProcessoAtivoPageState
    extends State<PesquisarProcessoAtivoPage> {
  final TextEditingController controllerProcesso = TextEditingController();

  @override
  void dispose() {
    controllerProcesso.dispose();
    super.dispose();
  }

  Future<void> pesquisarProcesso() async {
    final processoViewModel = Provider.of<ProcessoViewModel>(
      context,
      listen: false,
    );

    final termo = controllerProcesso.text.trim();

    if (termo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Informe o número do processo.")),
      );

      return;
    }

    try {
      await processoViewModel.pesquisarProcessoAtivo(termo);

      if (!mounted) return;

      if (processoViewModel.processosAtivoPesquisa.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nenhum processo encontrado.")),
        );

        return;
      }

      final ProcessoMinerario processoEncontrado =
          processoViewModel.processosAtivoPesquisa.first;

      debugPrint("Processo encontrado: ${processoEncontrado.processo}");

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetalheProcessoPage(
            idProcesso: processoEncontrado.idProcesso,
            modoCadastro: true,
          ),
        ),
      );
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro.toString().replaceFirst("Exception: ", "")),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final processoViewModel = Provider.of<ProcessoViewModel>(context);

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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text(
                    //   "Cadastrar Ativo Próprio",
                    //   style: TextStyle(
                    //     fontSize: 22,
                    //     fontWeight: FontWeight.w600,
                    //     color: const Color(0xFF5A81FA),
                    //   ),
                    // ),
                    // SizedBox(height: 60),
                    CampoInput(
                      controller: controllerProcesso,
                      label: "Número do processo",
                      obscureText: false,
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  Buttons(
                    texto: processoViewModel.carregandoProcessosAtivos
                        ? "Pesquisando..."
                        : "Pesquisar",
                    corBotao: const Color(0xFF5A81FA),
                    corTexto: Colors.white,
                    onPressed: () {
                      if (!processoViewModel.carregandoProcessosAtivos) {
                        pesquisarProcesso();
                      }
                    },
                  ),

                  const SizedBox(height: 8),

                  Buttons(
                    texto: "Ver Processos",
                    corBotao: Colors.white,
                    corTexto: const Color(0xFF5A81FA),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
