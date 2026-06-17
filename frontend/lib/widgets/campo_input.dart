import 'package:flutter/material.dart';

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
            hintStyle: TextStyle(fontSize: 16.0, color: Color(0xFFE0E0E0)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFE0E0E0)),
            ),
          ),
        ),
      ],
    );
  }
}
