import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/pages/usuario/editar_perfil_page.dart';
import 'package:frontend/services/ativo_service.dart';
import 'package:frontend/services/usuario_service.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';

class PerfilPage extends StatefulWidget {
  const PerfilPage({super.key});

  @override
  State<PerfilPage> createState() => _PerfilPageState();
}

class _PerfilPageState extends State<PerfilPage> {
  late Future<Usuario> _usuarioFuture;
  late Future<List<AtivoMinerario>> _ativosFuture;

  final TextEditingController controllerPesquisar = TextEditingController();

  String pesquisa = "";

  @override
  void initState() {
    super.initState();

    _usuarioFuture = UsuarioService().buscarPerfil();
    _ativosFuture = AtivoService().listar();
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
            child: SingleChildScrollView(
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
                      color: Color(0xFF5A81FA),
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarPerfilPage(usuario: usuario,),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: const Text("Editar perfil"),
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.logout),
                        label: const Text("Sair"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Meus Ativos",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A81FA),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),
                  PesquisarInput(
                    controller: controllerPesquisar,
                    onChanged: (valor) {
                      setState(() {
                        pesquisa = valor.toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 10),

                  FutureBuilder<List<AtivoMinerario>>(
                    future: _ativosFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      }

                      final ativos = snapshot.data!;

                      final ativosFiltrados = ativos.where((ativo) {
                        final processo = ativo.processoMinerario!;

                        return processo.processo.toLowerCase().contains(
                              pesquisa,
                            ) ||
                            processo.nome.toLowerCase().contains(pesquisa) ||
                            processo.subs.toLowerCase().contains(pesquisa) ||
                            processo.fase.toLowerCase().contains(pesquisa);
                      }).toList();

                      if (ativosFiltrados.isEmpty) {
                        return const Text(
                          "Você ainda não possui ativos cadastrados.",
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ativosFiltrados.length,
                        itemBuilder: (context, index) {
                          final ativo = ativosFiltrados[index];

                          return CardProcessoMinerario(
                            processo: ativo.processoMinerario!,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalheProcessoPage(
                                    idProcesso: ativo.idProcesso,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
