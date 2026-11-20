import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/pages/acesso/historico_solicitacoes_acesso_page.dart';
import 'package:frontend/pages/acesso/solicitacoes_acesso_enviadas_tab.dart';
import 'package:frontend/pages/acesso/solicitacoes_acesso_tab.dart';

class AcessoPage extends StatelessWidget {
  const AcessoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
          bottom: TabBar(
            labelColor: context.cores.primary,
            unselectedLabelColor: context.cores.onSurfaceVariant,
            indicatorColor: context.cores.primary,
            tabs: [
              Tab(text: "Pendentes"),
              Tab(text: "Histórico"),
              Tab(text: "Enviadas"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SolicitacoesAcessoTab(),
            HistoricoSolicitacoesAcessoPage(),
            SolicitacoesAcessoEnviadasTab()
          ],
        ),
      ),
    );
  }
}
