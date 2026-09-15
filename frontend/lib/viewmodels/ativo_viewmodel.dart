import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/services/ativo_service.dart';

class AtivoViewModel extends ChangeNotifier {
  final AtivoService _service = AtivoService();

  List<AtivoMinerario> ativos = [];
  bool carregandoAtivos = false;

  bool salvando = false;

  Future<void> listar() async {
    carregandoAtivos = true;
    notifyListeners();

    try {
      ativos = await _service.listar();
    } finally {
      carregandoAtivos = false;
      notifyListeners();
    }
  }

  Future<void> cadastrar(int idProcesso) async {
    final novoAtivo = AtivoMinerario(
      idProcesso: idProcesso,
      descricao: "Novo ativo cadastrado",
    );

    await _service.criar(novoAtivo);

    notifyListeners();
  }

  Future<void> atualizar(AtivoMinerario ativoAtualizado) async {
    salvando = true;
    notifyListeners();

    try {
      await _service.atualizar(ativoAtualizado.idAtivo!, ativoAtualizado);

      await listar();
    } finally {
      salvando = false;
      notifyListeners();
    }
  }
}
