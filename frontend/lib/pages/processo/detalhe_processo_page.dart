import 'package:flutter/material.dart';
import 'package:frontend/widgets/buttons/buttons.dart';

import '../../models/ativo_minerario.dart';
import '../../services/ativo_service.dart';
import '../../models/processo_minerario.dart';
import '../../services/processo_service.dart';

class DetalheProcessoPage extends StatefulWidget {
  final int idProcesso;
  final bool modoCadastro;

  const DetalheProcessoPage({
    super.key,
    required this.idProcesso,
    this.modoCadastro = false,
  });

  @override
  State<DetalheProcessoPage> createState() => _DetalheProcessoPageState();
}

class _DetalheProcessoPageState extends State<DetalheProcessoPage> {
  ProcessoMinerario? processo;
  AtivoMinerario? ativo;

  final AtivoService ativoService = AtivoService();

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    carregarDetalhes();
  }

  Future<void> carregarDetalhes() async {
    final resultado = await ProcessoService().buscarDetalhes(widget.idProcesso);

    setState(() {
      processo = resultado["processo"];
      ativo = resultado["ativo"];

      carregando = false;
    });
  }

  Future<void> cadastrarAtivo() async {
    try {
      final novoAtivo = AtivoMinerario(
        idProcesso: processo!.idProcesso,
        descricao: "Novo ativo cadastrado.",
      );

      await ativoService.criar(novoAtivo);

      await carregarDetalhes();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Ativo cadastrado com sucesso!")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (carregando) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

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
        padding: const EdgeInsets.all(24),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Processo", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.processo),

              const SizedBox(height: 12),
              Text("Substância", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.subs),

              const SizedBox(height: 12),
              Text("Ano", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.ano),

              const SizedBox(height: 12),
              Text("Área", style: TextStyle(color: Color(0xFF848484))),
              Text("${processo!.areaHa} ha"),

              const SizedBox(height: 12),
              Text("Fase", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.fase),

              const SizedBox(height: 12),
              Text("Último Evento", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.ultEvento),

              const SizedBox(height: 12),
              Text("Nome", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.nome),

              const SizedBox(height: 12),
              Text("Uso", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.uso),

              const SizedBox(height: 12),
              Text("DSProcesso", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.dsProcesso),

              const SizedBox(height: 12),
              Text("ID Processo", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.idAnm),

              const SizedBox(height: 12),
              Text("ID", style: TextStyle(color: Color(0xFF848484))),
              Text(processo!.idProcesso.toString()),

              const SizedBox(height: 12),

              if (ativo != null) ...[
                const Divider(),

                const SizedBox(height: 12),
                Text("Descrição", style: TextStyle(color: Color(0xFF848484))),
                Text(ativo!.descricao),

                const SizedBox(height: 12),
                Text("Titular", style: TextStyle(color: Color(0xFF848484))),
                Text(ativo!.usuario!.nome),

                const SizedBox(height: 12),
                Text(
                  "Data de Cadastro",
                  style: TextStyle(color: Color(0xFF848484)),
                ),
                Text(ativo!.dtCadastro.toString()),

                const SizedBox(height: 30),
              ],

              if (widget.modoCadastro && ativo == null) ...[
                const SizedBox(height: 30),

                Buttons(
                  texto: "Cadastrar Ativo",
                  corBotao: const Color(0xFF5A81FA),
                  corTexto: Colors.white,
                  onPressed: cadastrarAtivo
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
