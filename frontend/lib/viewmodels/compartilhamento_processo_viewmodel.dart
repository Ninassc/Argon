import 'package:flutter/material.dart';
import 'package:frontend/models/compartilhamento_processo.dart';
import 'package:frontend/services/compartilhamento_processo_service.dart';

class CompartilhamentoProcessoViewmodel extends ChangeNotifier {
  final CompartilhamentoProcessoService _service =
      CompartilhamentoProcessoService();

  List<CompartilhamentoProcesso> enviados = [];
  List<CompartilhamentoProcesso> recebidos = [];

  bool carregandoCompartilhar = false;
  bool carregandoEnviados = false;
  bool carregandoRecebidos = false;

  Future<void> compartilhar(int idProcesso, String email) async {
    try {
      carregandoCompartilhar = true;
      notifyListeners();
      await _service.compartilhar(idProcesso: idProcesso, email: email);
    } finally {
      carregandoCompartilhar = false;
      notifyListeners();
    }
  }

  Future<void> carregarEnviados() async {
    try {
      carregandoEnviados = true;
      notifyListeners();
      enviados = await _service.listarEnviados();
    } finally {
      carregandoEnviados = false;
      notifyListeners();
    }
  }

  Future<void> carregarRecebidos() async {
    try {
      carregandoRecebidos = true;
      notifyListeners();
      recebidos = await _service.listarRecebidos();
    } finally {
      carregandoRecebidos = false;
      notifyListeners();
    }
  }
}
