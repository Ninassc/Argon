import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/acesso.dart';
import '../../services/acesso_service.dart';

// importe também sua tela de detalhes do ativo/processo

class SolicitacoesAcessoPage extends StatefulWidget {
  const SolicitacoesAcessoPage({super.key});

  @override
  State<SolicitacoesAcessoPage> createState() => _SolicitacoesAcessoPageState();
}

class _SolicitacoesAcessoPageState extends State<SolicitacoesAcessoPage> {
  final AcessoService _acessoService = AcessoService();

  List<Acesso> solicitacoes = [];
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarSolicitacoes();
  }

  Future<void> carregarSolicitacoes() async {
    try {
      final resultado = await _acessoService.listarRecebidas();

      if (!mounted) return;

      setState(() {
        solicitacoes = resultado;
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

      body: carregando
          ? const Center(child: CircularProgressIndicator())
          : solicitacoes.isEmpty
          ? const Center(child: Text("Nenhuma solicitação de acesso pendente."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: solicitacoes.length,
              itemBuilder: (context, index) {
                final acesso = solicitacoes[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
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
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          acesso.usuario?.email ?? "",
                          style: const TextStyle(color: Color(0xFF848484)),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    acesso.ativo?.processoMinerario?.processo ??
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
                                // abrir tela de detalhes
                              },
                              icon: const Icon(Icons.visibility_outlined),
                              label: const Text("Ver"),
                            ),
                          ],
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

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  // recusar
                                },
                                child: const Text("Recusar"),
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  // aprovar
                                },
                                child: const Text("Aprovar"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
