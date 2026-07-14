import 'package:flutter/material.dart';
import 'package:frontend/pages/auth/login_page.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/textfields/campo_input.dart';
import 'package:frontend/widgets/tipo_conta.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/services/usuario_service.dart';

enum TipoUsuario { titular, interessado }

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerEmailTelefone = TextEditingController();
  final TextEditingController controllerSenha = TextEditingController();
  final TextEditingController controllerConfirmarSenha =
      TextEditingController();

  TipoUsuario _selecionado = TipoUsuario.titular;
  final _opcoes = ['Titular', 'Interessado'];

  final UsuarioService usuarioService = UsuarioService();

  @override
  void dispose() {
    controllerNome.dispose();
    controllerEmailTelefone.dispose();
    controllerSenha.dispose();
    controllerConfirmarSenha.dispose();
    super.dispose();
  }

  Future<void> cadastrar() async {
    if (controllerSenha.text != controllerConfirmarSenha.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("As senhas não coincidem.")));

      return;
    }

    final texto = controllerEmailTelefone.text.trim();

    final usuario = Usuario(
      nome: controllerNome.text.trim(),
      email: texto.contains("@") ? texto : null,
      telefone: texto.contains("@") ? null : texto,
      senha: controllerSenha.text,
      tipoConta: _selecionado == TipoUsuario.titular
          ? TipoConta.titular
          : TipoConta.interessado,
    );

    try {
      await usuarioService.criar(usuario);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Usuário cadastrado com sucesso!")),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              CampoInput(
                controller: controllerNome,
                label: "Nome Completo",
                obscureText: false,
              ),
              CampoInput(
                controller: controllerEmailTelefone,
                label: "Email ou Telefone",
                obscureText: false,
              ),

              TipoContaUsuario(
                opcoes: _opcoes,
                onChanged: (i) {
                  setState(() {
                    _selecionado = TipoUsuario.values[i];
                  });
                },
              ),

              CampoInput(
                controller: controllerSenha,
                label: "Senha",
                obscureText: true,
              ),
              CampoInput(
                controller: controllerConfirmarSenha,
                label: "Confirmar Senha",
                obscureText: true,
              ),

              SizedBox(height: 10),

              Buttons(
                texto: "Criar Conta",
                corBotao: const Color(0xFF5A81FA),
                corTexto: Colors.white,
                onPressed: cadastrar,
              ),
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
        ),
      ),
    );
  }
}
