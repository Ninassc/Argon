import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/processo_minerario.dart';
import '../models/ativo_minerario.dart';
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

  Future<Map<String, dynamic>> buscarDetalhes(int idProcesso) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos/$idProcesso/detalhes"),
    );

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);

      return {
        "processo": ProcessoMinerario.fromJson(json["processo"]),
        "ativo": json["ativo"] != null
            ? AtivoMinerario.fromJson(json["ativo"])
            : null,
      };
    }

    throw Exception("Erro ao buscar detalhes do processo.");
  }
}
