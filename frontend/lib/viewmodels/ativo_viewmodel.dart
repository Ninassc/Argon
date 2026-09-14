import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/services/ativo_service.dart';

class AtivoViewModel extends ChangeNotifier {
  final AtivoService _service = AtivoService();

  Future<void> cadastrar(int idProcesso) async {
    final novoAtivo = AtivoMinerario(
      idProcesso: idProcesso,
      descricao: "Novo ativo cadastrado",
    );

    await _service.criar(novoAtivo);

    notifyListeners();
  }
}
