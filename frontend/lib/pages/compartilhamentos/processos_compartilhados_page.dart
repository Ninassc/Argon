import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/pages/compartilhamentos/compartilhamentos_enviados_tab.dart';
import 'package:frontend/pages/compartilhamentos/compartilhamentos_recebidos_tab.dart';

class ProcessosCompartilhadosPage extends StatelessWidget {
  const ProcessosCompartilhadosPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
              Tab(text: "Recebidos"),
              Tab(text: "Enviados"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CompartilhamentosRecebidosTab(),
            CompartilhamentosEnviadosTab(),
          ],
        ),
      ),
    );
  }
}
