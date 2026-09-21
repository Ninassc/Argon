import 'package:flutter/material.dart';
import 'package:frontend/models/acesso.dart';

import '../services/acesso_service.dart';

class AcessoViewModel extends ChangeNotifier {
  final AcessoService _service = AcessoService();

  List<Acesso> solicitacoesRecebidas = [];
  List<Acesso> solicitacoesEnviadas = [];
  List<Acesso> historico = [];

  String? statusAcesso;
  bool verificandoAcesso = false;
  bool carregandoRecebidas = false;
  bool carregandoEnviadas = false;
  bool carregandoHistorico = false;

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

  Future<void> carregarEnviadas() async {
    carregandoEnviadas = true;
    notifyListeners();

    try {
      solicitacoesEnviadas = await _service.listarEnviadas();
    } finally {
      carregandoEnviadas = false;
      notifyListeners();
    }
  }

  Future<void> carregarRecebidas() async {
    carregandoRecebidas = true;
    notifyListeners();

    try {
      solicitacoesRecebidas = await _service.listarRecebidas();
    } finally {
      carregandoRecebidas = false;
      notifyListeners();
    }
  }

  Future<void> carregarHistorico() async {
    carregandoHistorico = true;
    notifyListeners();

    try {
      historico = await _service.listarHistoricoRecebido();
    } finally {
      carregandoHistorico = false;
      notifyListeners();
    }
  }

  Future<void> aprovar(int idAcesso) async {
    await _service.aprovar(idAcesso);
    solicitacoesRecebidas.removeWhere((acesso) => acesso.idAcesso == idAcesso);
  }

  Future<void> recusar(int idAcesso) async {
    await _service.recusar(idAcesso);
    solicitacoesRecebidas.removeWhere((acesso) => acesso.idAcesso == idAcesso);
  }
}
