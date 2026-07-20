import 'package:flutter/material.dart';

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
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFF5A81FA), width: 2),
        ),
        child: Icon(icone, color: const Color(0xFF5A81FA), size: 24),
      ),
    );
  }
}
