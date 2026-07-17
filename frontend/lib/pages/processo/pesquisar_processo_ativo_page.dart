import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';

import '../../models/processo_minerario.dart';
import '../../services/processo_service.dart';
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

  final ProcessoService processoService = ProcessoService();

  bool carregando = false;

  @override
  void dispose() {
    controllerProcesso.dispose();
    super.dispose();
  }

  Future<void> pesquisarProcesso() async {
    final termo = controllerProcesso.text.trim();

    if (termo.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Informe o número do processo.")),
      );

      return;
    }

    setState(() {
      carregando = true;
    });

    try {
      final processos = await processoService.pesquisar(
        termo: termo,
        page: 1,
        limit: 20,
      );

      if (!mounted) return;

      if (processos.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Nenhum processo encontrado.")),
        );

        return;
      }

      final ProcessoMinerario processoEncontrado = processos.first;

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

      // No próximo passo, vamos abrir a tela de detalhes aqui.
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro.toString().replaceFirst("Exception: ", "")),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          carregando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
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
                    texto: carregando ? "Pesquisando..." : "Pesquisar",
                    corBotao: const Color(0xFF5A81FA),
                    corTexto: Colors.white,
                    onPressed: () {
                      if (!carregando) {
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
