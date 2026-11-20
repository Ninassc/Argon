import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';
import 'package:frontend/pages/auth/cadastro_page.dart';
import 'package:frontend/pages/home/home_page.dart';
import 'package:frontend/pages/welcome/welcome_page.dart';
import 'package:frontend/viewmodels/auth_viewmodel.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/textfields/campo_input.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerEmailTelefone = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  Future<void> fazerLogin() async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

    try {
      await authViewModel.fazerLogin(
        controllerEmailTelefone.text.trim(),
        controllerSenha.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.cores.outlineVariant, width: 2),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: context.cores.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CampoInput(
                  controller: controllerEmailTelefone,
                  label: "Email ou Telefone",
                  obscureText: false,
                ),
                CampoInput(
                  controller: controllerSenha,
                  label: "Senha",
                  obscureText: true,
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Esqueci minha senha",
                    style: TextStyle(
                      color: context.cores.primary,
                      fontSize: 14,
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Buttons(
                  texto: "Entrar",
                  corBotao: context.cores.primary,
                  corTexto: context.cores.onPrimary,
                  onPressed: fazerLogin,
                ),
                Buttons(
                  texto: "Não Possuo uma Conta",
                  corBotao: context.cores.surface,
                  corTexto: context.cores.primary,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CadastroPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
