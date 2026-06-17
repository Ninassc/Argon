import 'package:flutter/material.dart';

class OnboardingPageWidget extends StatelessWidget {
  final String imagem;
  final String titulo;
  final String descricao;

  const OnboardingPageWidget({
    super.key,
    required this.imagem,
    required this.titulo,
    required this.descricao,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagem,
            height: 250,
          ),

          const SizedBox(height: 32),

          Text(
            titulo,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            descricao,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}