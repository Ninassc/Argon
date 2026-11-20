import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/viewmodels/exportacao_viewmodel.dart';
import 'package:frontend/widgets/bottom_sheets/compartilhar_processo_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CompartilharOpcoesBottomSheet extends StatelessWidget {
  final ProcessoMinerario processo;

  const CompartilharOpcoesBottomSheet({super.key, required this.processo});

  @override
  Widget build(BuildContext context) {
    final exportacaoViewModel = Provider.of<ExportacaoViewModel>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Compartilhar processo",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.cores.primary,
              ),
            ),

            const SizedBox(height: 20),

            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: context.cores.primary,
              ),
              title: const Text("Compartilhar no Argon"),
              subtitle: const Text(
                "Envie o processo para outro usuário da plataforma.",
              ),
              onTap: () {
                Navigator.pop(context);

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
                      idProcesso: processo.idProcesso,
                    );
                  },
                );
              },
            ),

            const Divider(),

            ListTile(
              leading: Icon(
                Icons.ios_share_outlined,
                color: context.cores.primary,
              ),
              title: Text(
                exportacaoViewModel.exportando
                    ? "Preparando planilha..."
                    : "Compartilhar externamente",
              ),
              subtitle: const Text(
                "Compartilhe a planilha por WhatsApp, e-mail e outros aplicativos.",
              ),
              onTap: exportacaoViewModel.exportando
                  ? null
                  : () async {
                      try {
                        await exportacaoViewModel.compartilharPlanilha(
                          processo,
                        );
                      } catch (e) {
                        if (!context.mounted) return;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              e.toString().replaceFirst("Exception: ", ""),
                            ),
                          ),
                        );
                      }
                    },
            ),
          ],
        ),
      ),
    );
  }
}
