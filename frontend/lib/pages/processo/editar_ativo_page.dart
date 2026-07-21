import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/services/ativo_service.dart';
import 'package:frontend/widgets/buttons/buttons.dart';

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

  final AtivoService ativoService = AtivoService();

  bool salvando = false;

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
    final descricao = controllerDescricao.text.trim();

    if (descricao.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Digite uma descrição para o ativo.")),
      );

      return;
    }

    setState(() {
      salvando = true;
    });

    try {
      final ativoAtualizado = AtivoMinerario(
        idAtivo: widget.ativo.idAtivo,
        idProcesso: widget.ativo.idProcesso,
        descricao: descricao,
      );

      await ativoService.atualizar(widget.ativo.idAtivo!, ativoAtualizado);
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
    } finally {
      if (mounted) {
        setState(() {
          salvando = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    color: Color(0xFFDBE3FE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.construction, color: Color(0xFF848484)),
                ),
                Text(
                  widget.processo.processo,
                  style: TextStyle(
                    color: Color(0xFF5A81FA),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Descrição",
                style: TextStyle(
                  color: Color(0xFF848484),
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
                hintStyle: const TextStyle(color: Color(0xFFBDBDBD)),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0xFF5A81FA),
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
                    texto: salvando ? "Salvando..." : "Salvar e Sair",
                    corBotao: const Color(0xFF5A81FA),
                    corTexto: Colors.white,
                    onPressed: () {
                      if (!salvando) {
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
