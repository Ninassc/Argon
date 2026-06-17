import 'package:flutter/material.dart';
import 'package:frontend/widgets/campo_input.dart';

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
        //title: Image.asset("assets/images/logo_argon.png", height: 50),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
            ],
          ),
        ),
      ),
    );
  }
}
