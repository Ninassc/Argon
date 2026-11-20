import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../theme/theme_preference.dart';

class BotaoTema extends StatelessWidget {
  const BotaoTema({super.key});

  @override
  Widget build(BuildContext context) {
    final preferencia = context.watch<PreferenciaTema>();
    final modo = preferencia.modo;

    return PopupMenuButton<ThemeMode>(
      tooltip: 'Tema do app',
      icon: Icon(switch (modo) {
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
        ThemeMode.system => Icons.brightness_auto_outlined,
      }),
      onSelected: (novoModo) async {
        try {
          await preferencia.alterar(novoModo);
        } catch (_) {
          if (!context.mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Não foi possível salvar o tema.')),
          );
        }
      },
      itemBuilder: (context) => [
        CheckedPopupMenuItem(
          value: ThemeMode.system,
          checked: modo == ThemeMode.system,
          child: const Text('Sistema'),
        ),
        CheckedPopupMenuItem(
          value: ThemeMode.light,
          checked: modo == ThemeMode.light,
          child: const Text('Claro'),
        ),
        CheckedPopupMenuItem(
          value: ThemeMode.dark,
          checked: modo == ThemeMode.dark,
          child: const Text('Escuro'),
        ),
      ],
    );
  }
}
