import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:intl/intl.dart';

import '../../models/acesso.dart';
import '../../services/acesso_service.dart';

class SolicitacoesAcessoEnviadasTab extends StatefulWidget {
  const SolicitacoesAcessoEnviadasTab({super.key});

  @override
  State<SolicitacoesAcessoEnviadasTab> createState() =>
      _SolicitacoesAcessoPageState();
}

class _SolicitacoesAcessoPageState
    extends State<SolicitacoesAcessoEnviadasTab> {
  final AcessoService _acessoService = AcessoService();

  List<Acesso> enviadas = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarSolicitacoes();
  }

  Future<void> carregarSolicitacoes() async {
    try {
      final resultado = await _acessoService.listarEnviadas();

      if (!mounted) return;

      setState(() {
        enviadas = resultado;
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
    return Scaffold(
      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : enviadas.isEmpty
          ? const Center(child: Text("Nenhuma solicitação de acesso pendente."))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    "*Solicitações de acesso enviadas por mim",
                    style: TextStyle(color: Color(0xFF848484), fontSize: 13),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: enviadas.length,
                      itemBuilder: (context, index) {
                        final acesso = enviadas[index];

                        return Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            side: BorderSide(color: Color(0xFFE0E0E0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  acesso.ativo?.usuario?.nome ?? "Usuário",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    // color: Color(0xFF5A81FA)
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  acesso.ativo?.usuario?.email ?? "",
                                  style: const TextStyle(
                                    color: Color(0xFF848484),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Ativo / Processo",
                                            style: TextStyle(
                                              color: Color(0xFF848484),
                                              fontSize: 13,
                                            ),
                                          ),

                                          const SizedBox(height: 4),

                                          Text(
                                            acesso
                                                    .ativo
                                                    ?.processoMinerario
                                                    ?.processo ??
                                                "Processo não informado",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DetalheProcessoPage(
                                                  idProcesso:
                                                      acesso.ativo!.idProcesso,
                                                ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.visibility_outlined,
                                      ),
                                      label: const Text("Ver"),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 16),

                                Text(
                                  "Status",
                                  style: TextStyle(
                                    color: Color(0xFF848484),
                                    fontSize: 13,
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  (acesso.status).toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const SizedBox(height: 16),


                                if (acesso.dtSolicitacao != null)
                                  Text(
                                    "Solicitado em ${DateFormat('dd/MM/yyyy HH:mm').format(acesso.dtSolicitacao!)}",
                                    style: const TextStyle(
                                      color: Color(0xFF848484),
                                      fontSize: 13,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
