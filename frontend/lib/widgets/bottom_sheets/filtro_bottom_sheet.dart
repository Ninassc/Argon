import 'package:flutter/material.dart';
import 'package:frontend/models/filtro_processo.dart';
import 'package:frontend/services/processo_service.dart';
import 'package:frontend/widgets/bottom_sheets/selecionar_substancia_bottom_sheet.dart';

class FiltroBottomSheet extends StatefulWidget {
  const FiltroBottomSheet({super.key});

  @override
  State<FiltroBottomSheet> createState() => _FiltroBottomSheetState();
}

class _FiltroBottomSheetState extends State<FiltroBottomSheet> {
  late Future<List<String>> futureFases;
  late Future<List<String>> futureSubstancias;

  String substanciaSelecionada = "Todas";

  String faseSelecionada = "Todas";

  @override
  void initState() {
    super.initState();

    futureFases = ProcessoService().listarFases();
    futureSubstancias = ProcessoService().listarSubstancias();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Filtrar Processos",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5A81FA),
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Fase",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),

            const SizedBox(height: 8),

            FutureBuilder<List<String>>(
              future: futureFases,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return const Text("Erro ao carregar as fases.");
                }

                final fases = snapshot.data ?? [];

                return DropdownButtonFormField<String>(
                  isExpanded: true,
                  initialValue: faseSelecionada,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Selecione uma fase",
                  ),
                  items: [
                    const DropdownMenuItem<String>(
                      value: "Todas",
                      child: Text("Todas"),
                    ),
                    ...fases.map(
                      (fase) => DropdownMenuItem<String>(
                        value: fase,
                        child: Text(fase, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      faseSelecionada = value!;
                    });
                  },
                );
              },
            ),
            const SizedBox(height: 10),

            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                "Substância",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              subtitle: Text(substanciaSelecionada),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final substancia = await showModalBottomSheet<String>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => const SelecionarSubstanciaBottomSheet(),
                );

                if (substancia != null) {
                  setState(() {
                    substanciaSelecionada = substancia;
                  });
                }
              },
            ),

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      
                    },
                    child: const Text("Limpar"),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Color(0xFF5A81FA),
                    ),
                    onPressed: () {
                      Navigator.pop(
                        context,
                        FiltroProcesso(
                          fase: faseSelecionada == "Todas"
                              ? null
                              : faseSelecionada,
                          substancia: substanciaSelecionada == "Todas"
                              ? null
                              : substanciaSelecionada,
                        ),
                      );
                    },
                    child: const Text("Aplicar"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
