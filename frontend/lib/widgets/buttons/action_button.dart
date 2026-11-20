import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icone;
  const ActionButton({super.key, required this.icone, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide(
            color: context.cores.outlineVariant
          )),
          backgroundColor: context.cores.surface
        ),
        child: Icon(icone, size: 24, color: context.cores.onSurfaceVariant,),
      ),
    );
  }
}
