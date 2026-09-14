import 'package:flutter/material.dart';
import 'package:frontend/models/favorito.dart';

import '../services/favorito_service.dart';

class FavoritoViewModel extends ChangeNotifier {
  final FavoritoService _service = FavoritoService();

  List<Favorito> favoritos = [];

  bool salvo = false;
  bool carregando = false;

  Future<void> carregarFavoritos() async {
    carregando = true;
    notifyListeners();
    
    try {
      favoritos = await _service.listar();
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> verificar(int idProcesso) async {
    carregando = true;
    notifyListeners();

    try {
      salvo = await _service.verificar(idProcesso);
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<String> alterar(int idProcesso) async {
    if (salvo) {
      await _service.remover(idProcesso);

      salvo = false;
      notifyListeners();

      return "Processo removido dos salvos.";
    }

    await _service.criar(idProcesso);

    salvo = true;
    notifyListeners();

    return "Processo salvo.";
  }
}
