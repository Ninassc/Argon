import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/models/processo_minerario.dart';

class CardProcessoMinerario extends StatelessWidget {
  final ProcessoMinerario processo;
  final VoidCallback? onTap;
  const CardProcessoMinerario({super.key, required this.processo, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: context.cores.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10),
          side: BorderSide(color: context.cores.outlineVariant),
        ),
        child: Padding(
          padding: EdgeInsetsGeometry.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Processo",
                        style: TextStyle(color: context.cores.onSurfaceVariant),
                      ),
                      Text(processo.processo),
                    ],
                  ),
      
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Substância",
                        style: TextStyle(color: context.cores.onSurfaceVariant),
                      ),
                      Text(processo.subs),
                    ],
                  ),
                ],
              ),

              Icon(
                Icons.open_in_new, color: context.cores.primary, size: 28
              )
            ],
          ),
        ),
      ),
    );
  }
}
