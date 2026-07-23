import 'package:flutter/material.dart';
import 'package:frontend/services/processo_service.dart';

class FiltroBottomSheet extends StatefulWidget {
  const FiltroBottomSheet({super.key});

  @override
  State<FiltroBottomSheet> createState() => _FiltroBottomSheetState();
}

class _FiltroBottomSheetState extends State<FiltroBottomSheet> {
  late Future<List<String>> futureFases;

  String faseSelecionada = "Todas";

  @override
  void initState() {
    super.initState();

    futureFases = ProcessoService().listarFases();
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

            const Text("Fase", style: TextStyle(fontWeight: FontWeight.w600)),

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

            const SizedBox(height: 32),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, "Todas"); // limpar = sem filtro
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
                        faseSelecionada,
                      ); // devolve a fase escolhida
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
