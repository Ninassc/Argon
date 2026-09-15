import 'package:flutter/material.dart';
import 'package:frontend/models/ativo_minerario.dart';
import 'package:frontend/models/filtro_processo.dart';
import 'package:frontend/models/processo_minerario.dart';
import 'package:frontend/services/processo_service.dart';

class ProcessoViewModel extends ChangeNotifier {
  final ProcessoService _service = ProcessoService();

  List<ProcessoMinerario> processosMinerarios = [];

  List<dynamic> processosAtivoPesquisa = [];

  FiltroProcesso filtro = const FiltroProcesso();

  int pagina = 1;
  final int limite = 20;

  bool carregando = false;
  bool temMais = true;

  String termoPesquisa = "";

  ProcessoMinerario? processo;
  AtivoMinerario? ativo;

  bool carregandoProcessos = false;

  bool carregandoProcessosAtivos = false;

  Future<void> carregarProcessos() async {
    if (carregandoProcessos || !temMais) return;

    carregandoProcessos = true;
    notifyListeners();

    try {
      final novos = termoPesquisa.isEmpty
          ? await _service.listar(
              page: pagina,
              limit: limite,
              fase: filtro.fase,
              substancia: filtro.substancia,
            )
          : await _service.pesquisar(
              termo: termoPesquisa,
              page: pagina,
              limit: limite,
              fase: filtro.fase,
              substancia: filtro.substancia,
            );

      processosMinerarios.addAll(novos);
      pagina++;

      if (novos.length < limite) {
        temMais = false;
      }
    } finally {
      carregandoProcessos = false;
      notifyListeners();
    }
  }

  Future<void> pesquisar(String texto) async {
    termoPesquisa = texto;

    pagina = 1;
    temMais = true;
    processosMinerarios.clear();

    notifyListeners();

    await carregarProcessos();
  }

  Future<void> aplicarFiltro(FiltroProcesso novoFiltro) async {
    filtro = novoFiltro;

    pagina = 1;
    temMais = true;
    processosMinerarios.clear();

    notifyListeners();

    await carregarProcessos();
  }

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

  Future<void> pesquisarProcessoAtivo(String termo) async{
    carregandoProcessosAtivos = true;
    notifyListeners();

    try{
      processosAtivoPesquisa = await _service.pesquisar(termo: termo, page: 1, limit: 20);
    }finally{
      carregandoProcessosAtivos = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> analisarComIa(int idProcesso) async {
    return await _service.analisarComIa(idProcesso);
  }
}
