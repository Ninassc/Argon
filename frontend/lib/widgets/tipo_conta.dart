// tipo_conta.dart
import 'package:flutter/material.dart';

class TipoContaUsuario extends StatefulWidget {
  final List<String> opcoes;
  final Function(int) onChanged;

  const TipoContaUsuario({super.key, required this.opcoes, required this.onChanged});

  @override
  State<TipoContaUsuario> createState() => _TipoContaUsuarioState();
}

class _TipoContaUsuarioState extends State<TipoContaUsuario> {
  int _selecionado = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 5,
      children: [
        Text("Tipo de Usuário"),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: Row(
            children: List.generate(widget.opcoes.length, (i) {
              final ativo = i == _selecionado;
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _selecionado = i);
                    widget.onChanged(i);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: i == 0 ? 0 : 4),
                    decoration: BoxDecoration(
                      color: ativo
                          ? const Color(0xFF5A81FA)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ativo
                            ? const Color(0xFF5A81FA)
                            : const Color(0xFFE0E0E0),
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.opcoes[i],
                      style: TextStyle(
                        color: ativo ? Colors.white : Colors.black54,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
