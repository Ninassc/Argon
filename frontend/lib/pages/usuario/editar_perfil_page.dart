import 'package:flutter/material.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/services/usuario_service.dart';
import 'package:frontend/widgets/buttons/buttons.dart';
import 'package:frontend/widgets/textfields/campo_input.dart';

class EditarPerfilPage extends StatefulWidget {
  final Usuario usuario;
  const EditarPerfilPage({super.key, required this.usuario});

  @override
  State<EditarPerfilPage> createState() => _EditarPerfilPageState();
}

class _EditarPerfilPageState extends State<EditarPerfilPage> {
  final TextEditingController controllerNome = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerTelefone = TextEditingController();

  final controllerSenhaAtual = TextEditingController();
  final controllerNovaSenha = TextEditingController();
  final controllerConfirmarSenha = TextEditingController();

  @override
  void initState() {
    super.initState();

    controllerNome.text = widget.usuario.nome;
    controllerEmail.text = widget.usuario.email ?? "";
    controllerTelefone.text = widget.usuario.telefone ?? "";
  }

  Future<void> atualizarPerfil() async {
    try {
      await UsuarioService().atualizarPerfil(
        nome: controllerNome.text,
        email: controllerEmail.text,
        telefone: controllerTelefone.text,
        tipoConta: widget.usuario.tipoConta,
      );

      final alterarSenha =
          controllerSenhaAtual.text.isNotEmpty ||
          controllerNovaSenha.text.isNotEmpty ||
          controllerConfirmarSenha.text.isNotEmpty;

      if (controllerNovaSenha.text != controllerConfirmarSenha.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("As senhas não coincidem.")),
        );
        return;
      }

      if (alterarSenha) {
        await UsuarioService().alterarSenha(
          senhaAtual: controllerSenhaAtual.text,
          novaSenha: controllerNovaSenha.text,
          confirmarSenha: controllerConfirmarSenha.text,
        );
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Perfil atualizado com sucesso!")),
      );

      Navigator.pop(context, true);
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
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFE0E0E0), width: 2),
              ),
              child: Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(0xFF848484),
              ),
            ),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsetsGeometry.all(24),
        child: Column(
          children: [
            Column(
              children: [
                const CircleAvatar(
                  radius: 42,
                  child: Icon(Icons.person, size: 42),
                ),

                const SizedBox(height: 12),

                Text(
                  widget.usuario.nome,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5A81FA),
                  ),
                ),

                Text(
                  widget.usuario.tipoConta.descricao,
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Informações Pessoais",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5A81FA),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerNome,
                  label: "Nome",
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerEmail,
                  label: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerTelefone,
                  label: "Telefone",
                  obscureText: false,
                ),

                const SizedBox(height: 25),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Segurança",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5A81FA),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerSenhaAtual,
                  label: "Senha atual",
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerNovaSenha,
                  label: "Nova senha",
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                CampoInput(
                  controller: controllerConfirmarSenha,
                  label: "Confirmar nova senha",
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                Buttons(
                  texto: "Salvar Alterações",
                  corBotao: const Color(0xFF5A81FA),
                  corTexto: Colors.white,
                  onPressed: atualizarPerfil,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
