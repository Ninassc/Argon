import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/services/processo_service.dart';

class ProcessoViewModel extends ChangeNotifier {
  final ProcessoService _service = ProcessoService();

  ProcessoMinerario? processo;
  AtivoMinerario? ativo;

  bool carregando = false;

  Future<void> buscarDetalhes(int idProcesso) async {
    carregando = true;
    notifyListeners();

    try {
      final detalhes = await _service.buscarDetalhes(idProcesso);

      processo = detalhes['processo'];
      ativo = detalhes['ativo'];
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> analisarComIa(int idProcesso) async {
    return await _service.analisarComIa(idProcesso);
  }
}
