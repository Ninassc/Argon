import 'package:flutter/material.dart';
import 'package:frontend/models/processo_minerario.dart';
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
  late Future<List<ProcessoMinerario>> processosMinerarios;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    processosMinerarios = ProcessoService().listar();
  }

  void pesquisar() {
    final termo = controller.text;

    setState(() {
      if (termo.isEmpty) {
        processosMinerarios = ProcessoService().listar();
      } else {
        processosMinerarios = ProcessoService().pesquisar(termo);
      }
    });
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
                      onChanged: (_) => pesquisar(),
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
                child: FutureBuilder<List<ProcessoMinerario>>(
                  future: processosMinerarios,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    }

                    final processos = snapshot.data!;

                    return ListView.builder(
                      itemCount: processos.length,
                      itemBuilder: (context, index) {
                        return CardProcessoMinerario(
                          processo: processos[index],
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
