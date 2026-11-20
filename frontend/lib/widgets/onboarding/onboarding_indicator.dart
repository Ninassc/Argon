import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

class OnboardingIndicator extends StatelessWidget {
  final int paginaAtual;

  const OnboardingIndicator({
    super.key,
    required this.paginaAtual,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: paginaAtual == index ? 40 : 20,
          height: 8,
          decoration: BoxDecoration(
            color: paginaAtual == index
                ? context.cores.primary
                : context.cores.outlineVariant,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}