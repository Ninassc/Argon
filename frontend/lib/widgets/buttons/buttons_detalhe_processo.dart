import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

class ButtonsDetalheProcesso extends StatelessWidget {
  final IconData icone;
  final VoidCallback onTap;

  const ButtonsDetalheProcesso({
    super.key,
    required this.icone,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: context.cores.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: context.cores.primary, width: 2),
        ),
        child: Icon(icone, color: context.cores.primary, size: 24),
      ),
    );
  }
}
