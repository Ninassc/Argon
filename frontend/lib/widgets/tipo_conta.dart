// tipo_conta.dart
import 'package:flutter/material.dart';
import 'package:frontend/theme/app_theme.dart';

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
                          ? context.cores.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ativo
                            ? context.cores.primary
                            : context.cores.outlineVariant,
                        width: 1.5,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      widget.opcoes[i],
                      style: TextStyle(
                        color: ativo ? context.cores.onPrimary : context.cores.onSurfaceVariant,
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
