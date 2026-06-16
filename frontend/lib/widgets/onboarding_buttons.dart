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
      child: Column(
        children: [
          Row(
            children: [
              if (paginaAtual > 0)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A81FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                    ),
                  ),
                ),

              if (paginaAtual > 0) SizedBox(width: 10),

              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // navegar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A81FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Comece a Pesquisar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),

              if (paginaAtual < 2) SizedBox(width: 10),

              if (paginaAtual < 2)
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF5A81FA),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },

                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 10),

          SizedBox(
            height: 48,
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // navegar
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: const Color(0xFF5A81FA), width: 2),
                ),
              ),
              child: const Text(
                "Já Possuo uma Conta",
                style: TextStyle(color: Color(0xFF5A81FA)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
