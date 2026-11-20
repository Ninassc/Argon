import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

class PesquisarInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const PesquisarInput({super.key, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Pesquisar...",
          hintStyle: TextStyle(
            fontSize: 16.0,
            color: context.cores.onSurfaceVariant,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: 28,
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
        onChanged: onChanged,
      ),
    );
  }
}
