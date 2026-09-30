import 'package:flutter/material.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/viewmodels/ativo_viewmodel.dart';
import 'package:frontend/viewmodels/usuario_viewmodel.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PerfilUsuarioPage extends StatefulWidget {
  final int idUsuario;

  const PerfilUsuarioPage({super.key, required this.idUsuario});

  @override
  State<PerfilUsuarioPage> createState() => _PerfilUsuarioPageState();
}

class _PerfilUsuarioPageState extends State<PerfilUsuarioPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UsuarioViewModel>(
        context,
        listen: false,
      ).buscarUsuarioPorId(widget.idUsuario);

      Provider.of<AtivoViewModel>(
        context,
        listen: false,
      ).listarAtivosUsuarioSelecionado(widget.idUsuario);
    });
  }

  @override
  Widget build(BuildContext context) {
    final usuarioViewModel = Provider.of<UsuarioViewModel>(context);
    final ativoViewModel = Provider.of<AtivoViewModel>(context);

    final usuario = usuarioViewModel.usuarioVisitado;
    final ativos = ativoViewModel.ativosUsuarioSelecionado;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
              ),
              child: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Color(0xFF848484),
              ),
            ),
          ),
        ),
      ),

      body: usuarioViewModel.carregandoUsuarioVisitado || usuario == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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

                    const SizedBox(height: 12),

                    Text(
                      usuario.dtCadastro != null
                          ? "Membro desde ${DateFormat('dd/MM/yyyy').format(usuario.dtCadastro!)}"
                          : "Data de cadastro não informada",
                      style: const TextStyle(color: Color(0xFF848484)),
                    ),

                    const SizedBox(height: 25),

                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Ativos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5A81FA),
                        ),
                      ),
                    ),

                    if (ativoViewModel.carregandoAtivosUsuario)
                      const Center(child: CircularProgressIndicator())
                    else if (ativos.isEmpty)
                      const Text(
                        "Este usuário ainda não possui ativos cadastrados.",
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ativos.length,
                        itemBuilder: (context, index) {
                          final ativo = ativos[index];

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
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
