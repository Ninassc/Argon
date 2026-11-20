import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
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
                    color: context.cores.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      color: context.cores.onPrimary,
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
                      backgroundColor: context.cores.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Comece a Pesquisar",
                      style: TextStyle(color: context.cores.onPrimary, fontSize: 16),
                    ),
                  ),
                ),
              ),

              if (paginaAtual < 2) SizedBox(width: 10),

              if (paginaAtual < 2)
                Container(
                  decoration: BoxDecoration(
                    color: context.cores.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    onPressed: () {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },

                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: context.cores.onPrimary,
                    ),
                  ),
                ),
            ],
          ),

          SizedBox(height: 10),

          Buttons(
            texto: "Já Possuo uma Conta",
            corBotao: context.cores.surface,
            corTexto: context.cores.primary,
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
