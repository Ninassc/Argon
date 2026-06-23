import 'package:flutter/material.dart';

class PesquisarInput extends StatelessWidget {
  final TextEditingController controller;
  const PesquisarInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: "Pesquisar...",
          hintStyle: TextStyle(fontSize: 16.0, color: Color(0xFFE0E0E0)),
          prefixIcon: Icon(Icons.search, size: 28, color: Color(0xFF848484)),
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
    );
  }
}
