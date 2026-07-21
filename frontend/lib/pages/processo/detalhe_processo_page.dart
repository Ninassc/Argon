import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/editar_ativo_page.dart';
import 'package:frontend/storage/auth_storage.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/buttons/buttons_detalhe_processo.dart';

import '../../models/ativo_minerario.dart';
import '../../services/ativo_service.dart';
import '../../models/processo_minerario.dart';
import '../../services/processo_service.dart';
import '../../models/usuario.dart';

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
  Usuario? usuarioLogado;

  final AtivoService ativoService = AtivoService();

  bool carregando = true;

  @override
  void initState() {
    super.initState();

    carregarDetalhes();
  }

  Future<void> carregarDetalhes() async {
    final resultado = await ProcessoService().buscarDetalhes(widget.idProcesso);
    final usuario = await AuthStorage().buscarUsuario();

    if (!mounted) return;

    setState(() {
      processo = resultado["processo"];
      ativo = resultado["ativo"];
      usuarioLogado = usuario;

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
    final bool podeEditar =
        ativo != null &&
        usuarioLogado != null &&
        ativo!.idUsuario == usuarioLogado!.idUsuario;

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
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SelectableText(
                            "Processo",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.processo),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Substância",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.subs),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Ano",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.ano),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Área",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText("${processo!.areaHa} ha"),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Fase",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.fase),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Último Evento",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.ultEvento),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Nome",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.nome),

                          const SizedBox(height: 12),
                          SelectableText(
                            "Uso",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.uso),

                          const SizedBox(height: 12),
                          SelectableText(
                            "DSProcesso",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.dsProcesso),

                          const SizedBox(height: 12),
                          SelectableText(
                            "ID Processo",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.idAnm),

                          const SizedBox(height: 12),
                          SelectableText(
                            "ID",
                            style: TextStyle(color: Color(0xFF848484)),
                          ),
                          SelectableText(processo!.idProcesso.toString()),

                          const SizedBox(height: 12),

                          if (ativo != null) ...[
                            const Divider(),

                            const SizedBox(height: 12),
                            SelectableText(
                              "Descrição",
                              style: TextStyle(color: Color(0xFF848484)),
                            ),
                            SelectableText(ativo!.descricao),

                            const SizedBox(height: 12),
                            SelectableText(
                              "Titular",
                              style: TextStyle(color: Color(0xFF848484)),
                            ),
                            SelectableText(ativo!.usuario!.nome),

                            const SizedBox(height: 12),
                            SelectableText(
                              "Data de Cadastro",
                              style: TextStyle(color: Color(0xFF848484)),
                            ),
                            SelectableText(ativo!.dtCadastro.toString()),

                            const SizedBox(height: 30),
                          ],
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        if (podeEditar) ...[
                          ButtonsDetalheProcesso(
                            icone: Icons.edit_outlined,
                            onTap: () async {
                              final alterou = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarAtivoPage(
                                    ativo: ativo!,
                                    processo: processo!,
                                  ),
                                ),
                              );

                              if (alterou == true) {
                                await carregarDetalhes();
                              }
                            },
                          ),

                          const SizedBox(height: 12),
                        ],

                        ButtonsDetalheProcesso(
                          icone: Icons.share_outlined,
                          onTap: () {
                            
                          },
                        ),

                        const SizedBox(height: 12),

                        ButtonsDetalheProcesso(
                          icone: Icons.bookmark_border,
                          onTap: () {
                           
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.modoCadastro && ativo == null) ...[
                const SizedBox(height: 10),
                Buttons(
                  texto: "Cadastrar Ativo",
                  corBotao: const Color(0xFF5A81FA),
                  corTexto: Colors.white,
                  onPressed: cadastrarAtivo,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
