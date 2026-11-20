import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

class CampoInput extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;

  const CampoInput({super.key, required this.controller, required this.label, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text(label),

        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: context.cores.onSurfaceVariant,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.cores.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: context.cores.primary),
            ),
          ),
        ),
      ],
    );
  }
}
