import 'package:flutter/material.dart';
import 'package:frontend/widgets/buttons/action_button.dart';
import 'package:frontend/widgets/textfields/pesquisar_input.dart';

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
                  ActionButton(icone: Icons.remove_red_eye_outlined, onPressed: (){}),
                  ActionButton(icone: Icons.tune, onPressed: (){})
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
