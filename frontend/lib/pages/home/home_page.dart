import 'package:flutter/material.dart';
import '../../widgets/onboarding_buttons.dart';
import '../../widgets/onboarding_indicator.dart';
import '../../widgets/onboarding_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController controller = PageController();

  int paginaAtual = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Image.asset(
              "assets/images/logo_argon.png",
              height: 50,
            ),

            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    paginaAtual = index;
                  });
                },
                children: const [
                  OnboardingPageWidget(
                    imagem: "assets/images/onboarding1.png",
                    titulo: "Organize seus ativos minerários",
                    descricao:
                        "Centralize informações e documentos em um único lugar.",
                  ),

                  OnboardingPageWidget(
                    imagem: "assets/images/onboarding2.png",
                    titulo: "Compartilhe com segurança",
                    descricao:
                        "Controle quem pode acessar os documentos dos seus ativos.",
                  ),

                  OnboardingPageWidget(
                    imagem: "assets/images/onboarding3.png",
                    titulo: "Valide dados oficiais",
                    descricao:
                        "Utilize informações da ANM para apresentar ativos com mais confiança.",
                  ),
                ],
              ),
            ),

            OnboardingIndicator(
              paginaAtual: paginaAtual,
            ),

            const SizedBox(height: 24),

            OnboardingButtons(
              paginaAtual: paginaAtual,
              controller: controller,
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}