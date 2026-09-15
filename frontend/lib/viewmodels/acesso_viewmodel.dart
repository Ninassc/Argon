import 'package:flutter/material.dart';

import '../services/acesso_service.dart';

class AcessoViewModel extends ChangeNotifier {
  final AcessoService _service = AcessoService();

  String? statusAcesso;
  bool verificandoAcesso = false;

  Future<void> verificar(int idAtivo) async {
    verificandoAcesso = true;
    notifyListeners();

    try {
      final resultado = await _service.verificar(idAtivo);

      statusAcesso = resultado["status"];
    } finally {
      verificandoAcesso = false;
      notifyListeners();
    }
  }

  Future<void> solicitar(int idAtivo) async {
    await _service.solicitar(idAtivo);

    statusAcesso = "pendente";
    notifyListeners();
  }
}