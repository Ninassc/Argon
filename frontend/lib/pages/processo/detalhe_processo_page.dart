import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/editar_ativo_page.dart';
import 'package:frontend/services/acesso_service.dart';
import 'package:frontend/storage/auth_storage.dart';
import 'package:frontend/widgets/bottom_sheets/compartilhar_processo_bottom_sheet.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/buttons/buttons_detalhe_processo.dart';

import '../../models/ativo_minerario.dart';
import '../../services/ativo_service.dart';
import '../../models/processo_minerario.dart';
import '../../services/processo_service.dart';
import '../../models/usuario.dart';
import '../../services/favorito_service.dart';

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

  TextEditingController controllerEmail = TextEditingController();

  final AtivoService ativoService = AtivoService();

  bool carregando = true;

  bool salvo = false;

  String? statusAcesso;
  bool verificandoAcesso = false;

  @override
  void initState() {
    super.initState();

    carregarDetalhes();
  }

  Future<void> carregarDetalhes() async {
    final resultado = await ProcessoService().buscarDetalhes(widget.idProcesso);

    final usuario = await AuthStorage().buscarUsuario();

    final processoSalvo = await FavoritoService().verificar(widget.idProcesso);

    if (!mounted) return;

    setState(() {
      processo = resultado["processo"];
      ativo = resultado["ativo"];
      usuarioLogado = usuario;

      salvo = processoSalvo;

      carregando = false;
    });

    if (ativo != null) {
      await verificarAcesso();
    }
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

  Future<void> alterarFavorito() async {
    try {
      if (salvo) {
        await FavoritoService().remover(processo!.idProcesso);

        if (!mounted) return;

        setState(() {
          salvo = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Processo removido dos salvos.")),
        );
      } else {
        await FavoritoService().criar(processo!.idProcesso);

        if (!mounted) return;

        setState(() {
          salvo = true;
        });

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Processo salvo.")));
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> analisarComIa() async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final resultado = await ProcessoService().analisarComIa(
        processo!.idProcesso,
      );

      if (!mounted) return;

      Navigator.pop(context);

      mostrarAnaliseIa(resultado);
    } catch (e) {
      if (!mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> verificarAcesso() async {
    if (ativo == null) return;

    try {
      setState(() {
        verificandoAcesso = true;
      });

      final resultado = await AcessoService().verificar(ativo!.idAtivo!);

      if (!mounted) return;

      setState(() {
        statusAcesso = resultado["status"];
        verificandoAcesso = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        verificandoAcesso = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  Future<void> solicitarAcesso() async {
    if (ativo == null) return;

    try {
      await AcessoService().solicitar(ativo!.idAtivo!);

      if (!mounted) return;

      setState(() {
        statusAcesso = "pendente";
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Solicitação de acesso enviada!")),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  void mostrarAnaliseIa(Map<String, dynamic> analise) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        final pontos = List<String>.from(analise["pontos_atencao"] ?? []);

        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.85,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Análise com IA",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5A81FA),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Resumo",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(analise["resumo"] ?? ""),

                  const SizedBox(height: 20),

                  const Text(
                    "Situação atual",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(analise["situacao_atual"] ?? ""),

                  const SizedBox(height: 20),

                  const Text(
                    "Pontos de atenção",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  ...pontos.map(
                    (ponto) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("• "),
                          Expanded(child: Text(ponto)),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Observação",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    analise["observacao"] ?? "",
                    style: const TextStyle(color: Color(0xFF848484)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
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
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              builder: (context) {
                                return CompartilharProcessoBottomSheet(
                                  idProcesso: processo!.idProcesso,
                                );
                              },
                            );
                          },
                        ),

                        const SizedBox(height: 12),

                        ButtonsDetalheProcesso(
                          icone: salvo ? Icons.bookmark : Icons.bookmark_border,
                          onTap: alterarFavorito,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Buttons(
                texto: "Analisar com IA",
                corBotao: const Color(0xFF5A81FA),
                corTexto: Colors.white,
                onPressed: analisarComIa,
              ),

              const SizedBox(height: 12),

              if (ativo != null && !podeEditar) ...[
                if (verificandoAcesso)
                  const CircularProgressIndicator()
                else if (statusAcesso == null)
                  Buttons(
                    texto: "Solicitar Acesso",
                    corBotao: const Color(0xFF5A81FA),
                    corTexto: Colors.white,
                    onPressed: solicitarAcesso,
                  )
                else if (statusAcesso == "pendente")
                  const Text(
                    "Solicitação de acesso pendente",
                    style: TextStyle(color: Color(0xFF848484)),
                  )
                else if (statusAcesso == "aprovado")
                  const Text(
                    "Você possui acesso a este ativo",
                    style: TextStyle(color: Color(0xFF848484)),
                  )
                else if (statusAcesso == "recusado")
                  const Text(
                    "Solicitação de acesso recusada",
                    style: TextStyle(color: Color(0xFF848484)),
                  ),

                const SizedBox(height: 12),
              ],

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
