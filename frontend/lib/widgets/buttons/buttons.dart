import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final String texto;
  final Color corBotao;
  final Color corTexto;
  final VoidCallback onPressed;

  const Buttons({
    super.key,
    required this.texto,
    required this.corBotao,
    required this.corTexto,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: corBotao,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color:
                  texto == "Entrar" ||
                      texto == "Criar Conta" ||
                      texto == "Pesquisar" ||
                      texto == "Cadastrar Ativo" ||
                      texto == "Pesquisando..." ||
                      texto == "Salvar e Sair" ||
                      texto == "Salvando..." ||
                      texto == "Salvar Alterações"
                  ? corBotao
                  : corTexto,
              width: 2,
            ),
          ),
        ),
        child: Text(texto, style: TextStyle(color: corTexto, fontSize: 16)),
      ),
    );
  }
}
