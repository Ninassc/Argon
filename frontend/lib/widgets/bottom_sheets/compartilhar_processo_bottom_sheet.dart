import 'package:flutter/material.dart';
import 'package:frontend/viewmodels/compartilhamento_processo_viewmodel.dart';
import 'package:provider/provider.dart';

class CompartilharProcessoBottomSheet extends StatefulWidget {
  final int idProcesso;

  const CompartilharProcessoBottomSheet({super.key, required this.idProcesso});

  @override
  State<CompartilharProcessoBottomSheet> createState() =>
      _CompartilharProcessoBottomSheetState();
}

class _CompartilharProcessoBottomSheetState
    extends State<CompartilharProcessoBottomSheet> {
  final TextEditingController controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    super.dispose();
  }

  Future<void> compartilhar() async {
    final compartilhamentoProcessoViewmodel =
        Provider.of<CompartilhamentoProcessoViewmodel>(context, listen: false);

    final email = controllerEmail.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Informe o e-mail do usuário.")),
      );

      return;
    }

    try {
      await compartilhamentoProcessoViewmodel.compartilhar(
        widget.idProcesso,
        email,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Processo compartilhado com sucesso.")),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceFirst("Exception: ", ""))),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final compartilhamentoProcessoViewmodel =
        Provider.of<CompartilhamentoProcessoViewmodel>(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Compartilhar processo",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5A81FA),
            ),
          ),

          const SizedBox(height: 20),

          TextField(
            controller: controllerEmail,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: "E-mail do usuário",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed:
                      compartilhamentoProcessoViewmodel.carregandoCompartilhar
                      ? null
                      : () => Navigator.pop(context),
                  child: const Text("Cancelar"),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF5A81FA),
                  ),
                  onPressed:
                      compartilhamentoProcessoViewmodel.carregandoCompartilhar
                      ? null
                      : compartilhar,
                  child:
                      compartilhamentoProcessoViewmodel.carregandoCompartilhar
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text("Compartilhar"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
