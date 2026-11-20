import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/viewmodels/ativo_viewmodel.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:provider/provider.dart';

class EditarAtivoPage extends StatefulWidget {
  final AtivoMinerario ativo;
  final ProcessoMinerario processo;
  const EditarAtivoPage({
    super.key,
    required this.ativo,
    required this.processo,
  });

  @override
  State<EditarAtivoPage> createState() => _EditarAtivoPageState();
}

class _EditarAtivoPageState extends State<EditarAtivoPage> {
  final TextEditingController controllerDescricao = TextEditingController();

  @override
  void initState() {
    super.initState();

    controllerDescricao.text = widget.ativo.descricao;
  }

  @override
  void dispose() {
    controllerDescricao.dispose();
    super.dispose();
  }

  Future<void> salvarAlteracoes() async {
    final ativoViewModel = Provider.of<AtivoViewModel>(context, listen: false);

    final descricao = controllerDescricao.text.trim();

    if (descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Digite uma descrição para o ativo.")),
      );

      return;
    }

    try {
      await ativoViewModel.atualizar(
        AtivoMinerario(
          idAtivo: widget.ativo.idAtivo,
          idProcesso: widget.processo.idProcesso,
          idUsuario: widget.ativo.idUsuario,
          descricao: descricao,
        ),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ativo atualizado com sucesso!")),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ativoViewModel = Provider.of<AtivoViewModel>(context);

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
                border: Border.all(color: context.cores.outlineVariant, width: 2),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: context.cores.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 20,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: context.cores.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.construction, color: context.cores.onSurfaceVariant),
                ),
                Text(
                  widget.processo.processo,
                  style: TextStyle(
                    color: context.cores.primary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Descrição",
                style: TextStyle(
                  color: context.cores.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(height: 8),

            TextField(
              controller: controllerDescricao,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: "Escreva a descrição...",
                hintStyle: TextStyle(color: context.cores.onSurfaceVariant),
                filled: true,
                fillColor: context.cores.surface,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: context.cores.outlineVariant),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: context.cores.outlineVariant),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: context.cores.primary,
                    width: 2,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Buttons(
                    texto: ativoViewModel.salvando
                        ? "Salvando..."
                        : "Salvar e Sair",
                    corBotao: context.cores.primary,
                    corTexto: context.cores.onPrimary,
                    onPressed: () {
                      if (!ativoViewModel.salvando) {
                        salvarAlteracoes();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
