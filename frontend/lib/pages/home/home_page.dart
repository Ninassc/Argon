import 'package:flutter/material.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/widgets/buttons/action_button.dart';
import 'package:frontend/widgets/buttons/button_speed_child.dart';
import 'package:frontend/widgets/cards/card_processo_minerario.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../../data/processos_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
                  Expanded(child: PesquisarInput(controller: controller)),
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
                  itemCount: processos.length,
                  itemBuilder: (context, index) {
                    ProcessoMinerario processo = processos[index];
                    return CardProcessoMinerario(processo: processo);
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
