import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/cadastro_page.dart';
import 'package:frontend/pages/auth/login_page.dart';
import 'package:frontend/widgets/buttons/buttons.dart';

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CadastroPage();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5A81FA),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Comece a Pesquisar",
                      style: TextStyle(color: Colors.white, fontSize: 16),
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

          Buttons(
            texto: "Já Possuo uma Conta",
            corBotao: Colors.white,
            corTexto: const Color(0xFF5A81FA),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
