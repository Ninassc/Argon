import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/processo_minerario.dart';
import 'api_service.dart';

class ProcessoService {
  Future<List<ProcessoMinerario>> listar({int page = 1, int limit = 20}) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos?page=$page&limit=$limit"),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List<dynamic> lista = json["processos"];

      return lista.map((e) => ProcessoMinerario.fromJson(e)).toList();
    }

    throw Exception("Erro ao carregar processos.");
  }

  Future<ProcessoMinerario> buscarPorId(int idProcesso) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos/$idProcesso"),
    );

    if (response.statusCode == 404) {
      throw Exception("Processo minerário não encontrado.");
    }

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar processo minerário.");
    }

    final json = jsonDecode(response.body);

    return ProcessoMinerario.fromJson(json);
  }

  Future<List<ProcessoMinerario>> pesquisar({
    required String termo,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/processos/pesquisar"
        "?termo=$termo&page=$page&limit=$limit",
      ),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      final List processos = json["processos"];

      return processos.map((e) => ProcessoMinerario.fromJson(e)).toList();
    }

    throw Exception("Erro ao pesquisar.");
  }
}
