import 'package:flutter/material.dart';
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
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
                ),
                child: const Icon(
                  Icons.chevron_left,
                  size: 30,
                  color: Color(0xFF848484),
                ),
              ),
            ),
          ),
          bottom: const TabBar(
            labelColor: Color(0xFF5A81FA),
            unselectedLabelColor: Color(0xFF848484),
            indicatorColor: Color(0xFF5A81FA),
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
