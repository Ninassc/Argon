import 'package:flutter/material.dart';
import '../../widgets/onboarding/onboarding_buttons.dart';
import '../../widgets/onboarding/onboarding_indicator.dart';
import '../../widgets/onboarding/onboarding_page_widget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
      ),

      body: SafeArea(
        child: Column(
          children: [
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
                        "Organize seus processos minerários com mais clareze, segurança e controle",
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

            OnboardingIndicator(paginaAtual: paginaAtual),

            const SizedBox(height: 24),

            OnboardingButtons(paginaAtual: paginaAtual, controller: controller),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
