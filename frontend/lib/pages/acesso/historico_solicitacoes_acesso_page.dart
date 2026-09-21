import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/viewmodels/acesso_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/acesso.dart';

class HistoricoSolicitacoesAcessoPage extends StatefulWidget {
  const HistoricoSolicitacoesAcessoPage({super.key});

  @override
  State<HistoricoSolicitacoesAcessoPage> createState() =>
      _SolicitacoesAcessoPageState();
}

class _SolicitacoesAcessoPageState
    extends State<HistoricoSolicitacoesAcessoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AcessoViewModel>(context, listen: false).carregarHistorico();
    });
  }

  @override
  Widget build(BuildContext context) {
    final acessoViewModel = Provider.of<AcessoViewModel>(context);
    List<Acesso> historico = acessoViewModel.historico;

    return Scaffold(
      body: acessoViewModel.carregandoHistorico
          ? const Center(child: CircularProgressIndicator())
          : historico.isEmpty
          ? const Center(child: Text("Nenhuma solicitação de acesso pendente."))
          : Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 16,
                children: [
                  Text(
                    "*Histórico de solicitações de acesso recebidas",
                    style: TextStyle(color: Color(0xFF848484), fontSize: 13),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: historico.length,
                      itemBuilder: (context, index) {
                        final acesso = historico[index];

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
                                  acesso.usuario?.nome ?? "Usuário",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    // color: Color(0xFF5A81FA)
                                  ),
                                ),

                                const SizedBox(height: 4),

                                Text(
                                  acesso.usuario?.email ?? "",
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
