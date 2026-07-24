import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/processo_minerario.dart';
import '../models/ativo_minerario.dart';
import 'api_service.dart';

class ProcessoService {
  Future<List<ProcessoMinerario>> listar({
    int page = 1,
    int limit = 20,
    String? fase,
    String? substancia,
  }) async {
    final queryParams = {
      "page": page.toString(),
      "limit": limit.toString(),
      if (fase != null && fase.isNotEmpty) "fase": fase,
      if (substancia != null) "substancia": substancia,
    };

    final uri = Uri.parse(
      "${ApiService.baseUrl}/processos",
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

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
    String? fase,
    String? substancia,
  }) async {
    final queryParams = {
      "termo": termo,
      "page": page.toString(),
      "limit": limit.toString(),
      if (fase != null && fase.isNotEmpty) "fase": fase,
      if (substancia != null) "substancia": substancia,
    };

    final uri = Uri.parse(
      "${ApiService.baseUrl}/processos/pesquisar",
    ).replace(queryParameters: queryParams);

    final response = await http.get(uri);

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

  Future<List<String>> listarFases() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos/fases"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar as fases.");
    }

    return List<String>.from(jsonDecode(response.body));
  }

  Future<List<String>> listarSubstancias() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos/substancias"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar as substâncias.");
    }

    return List<String>.from(jsonDecode(response.body));
  }
}
