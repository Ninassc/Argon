import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/cadastro_page.dart';
import 'package:frontend/pages/home/home_page.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/textfields/campo_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController controllerEmailTelefone = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
      ),
      body: SafeArea(
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
                    color: const Color(0xFF5A81FA),
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Buttons(
                texto: "Entrar",
                corBotao: const Color(0xFF5A81FA),
                corTexto: Colors.white,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
              Buttons(
                texto: "Não Possuo uma Conta",
                corBotao: Colors.white,
                corTexto: const Color(0xFF5A81FA),
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
    );
  }
}
