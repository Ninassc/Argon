import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/services/ativo_service.dart';
import 'package:frontend/services/usuario_service.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Future<Usuario> _usuarioFuture;
  late Future<List<AtivoMinerario>> _ativosFuture;

  @override
  void initState() {
    super.initState();

    _usuarioFuture = UsuarioService().buscarPerfil();
    //_ativosFuture = AtivoService().listar();
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

      body: FutureBuilder<Usuario>(
        future: _usuarioFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final usuario = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 42,
                        child: Icon(Icons.person, size: 42),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        usuario.nome,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A81FA)
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        usuario.email ?? usuario.telefone ?? "Não informado",
                        style: const TextStyle(color: Color(0xFF848484)),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Membro desde ${usuario.dtCadastro}",
                        style: const TextStyle(color: Color(0xFF848484)),
                      ),

                      const SizedBox(height: 20),

                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.edit),
                        label: const Text("Editar perfil"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
