import 'package:flutter/material.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/pages/processo/detalhe_processo_page.dart';
import 'package:frontend/services/processo_service.dart';
import 'package:frontend/widgets/buttons/action_button.dart';
import 'package:frontend/widgets/buttons/button_speed_child.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
//import '../../data/processos_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  List<ProcessoMinerario> processosMinerarios = [];

  int pagina = 1;
  final int limite = 20;

  bool carregando = false;
  bool temMais = true;

  String termoPesquisa = "";

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    carregarProcessos();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 300) {
        carregarProcessos();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    controller.dispose();
    super.dispose();
  }

  Future<void> carregarProcessos() async {
    if (carregando || !temMais) return;

    carregando = true;

    final novos = termoPesquisa.isEmpty
        ? await ProcessoService().listar(page: pagina, limit: limite)
        : await ProcessoService().pesquisar(
            termo: termoPesquisa,
            page: pagina,
            limit: limite,
          );

    print("========== Página $pagina ==========");

    for (var processo in novos) {
      print(processo.processo);
    }

    setState(() {
      processosMinerarios.addAll(novos);

      pagina++;

      carregando = false;

      if (novos.length < limite) {
        temMais = false;
      }
    });
  }

  Future<void> pesquisar(String texto) async {
    termoPesquisa = texto;

    setState(() {
      pagina = 1;
      temMais = true;
      processosMinerarios.clear();
    });

    await carregarProcessos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset("assets/images/ArgON.png", height: 42),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(24),
          child: Column(
            children: [
              Row(
                spacing: 5,
                children: [
                  Expanded(
                    child: PesquisarInput(
                      controller: controller,
                      onChanged: pesquisar, //(_) => pesquisar(),
                    ),
                  ),
                  ActionButton(
                    icone: Icons.remove_red_eye_outlined,
                    onPressed: () {},
                  ),
                  ActionButton(icone: Icons.tune, onPressed: () {}),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: processosMinerarios.length + (temMais ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == processosMinerarios.length) {
                      return const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return CardProcessoMinerario(
                      processo: processosMinerarios[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DetalheProcessoPage(
                              idProcesso: processosMinerarios[index].idProcesso,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: SpeedDial(
                  buttonSize: const Size(56, 56), // botão principal
                  childrenButtonSize: const Size(56, 56),
                  icon: Icons.add,
                  iconTheme: IconThemeData(color: Colors.white),
                  activeIcon: Icons.remove,
                  backgroundColor: Color(0xFF5A81FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(12),
                  ),
                  children: [
                    buttonSpeedChild(
                      icone: Icons.check_box_outlined,
                      label: 'Cadastrar Ativo Próprio',
                      onTap: () {},
                    ),
                    buttonSpeedChild(
                      icone: Icons.bookmark_border,
                      label: 'Salvos',
                      onTap: () {},
                    ),
                    buttonSpeedChild(
                      icone: Icons.person_outline,
                      label: 'Perfil',
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
