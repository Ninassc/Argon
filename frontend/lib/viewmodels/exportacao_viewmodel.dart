import 'package:flutter/material.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/services/exportacao_service.dart';

class ExportacaoViewModel extends ChangeNotifier {
  final ExportacaoService _service = ExportacaoService();

  bool exportando = false;

  Future<List<int>?> gerarPlanilha(ProcessoMinerario processo) async {
    exportando = true;
    notifyListeners();

    try {
      return _service.gerarPlanilha(processo);
    } finally {
      exportando = false;
      notifyListeners();
    }
  }

  Future<void> compartilharPlanilha(ProcessoMinerario processo) async {
    exportando = true;
    notifyListeners();

    try {
      await _service.compartilharPlanilha(processo);
    } finally {
      exportando = false;
      notifyListeners();
    }
  }
}
