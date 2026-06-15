import 'package:flutter/material.dart';

class OnboardingButtons extends StatelessWidget {
  final int paginaAtual;
  final PageController controller;

  const OnboardingButtons({
    super.key,
    required this.paginaAtual,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          if (paginaAtual > 0)
            IconButton(
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),

          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // navegar
              },
              child: const Text(
                "Comece a Pesquisar",
              ),
            ),
          ),

          if (paginaAtual < 2)
            IconButton(
              onPressed: () {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              icon: const Icon(Icons.arrow_forward_ios),
            ),
        ],
      ),
    );
  }
}