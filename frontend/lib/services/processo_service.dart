import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/processo_minerario.dart';
import 'api_service.dart';

class ProcessoService {

  Future<List<ProcessoMinerario>> listar() async {

    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/processos/"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar processos.");
    }

    final List<dynamic> json = jsonDecode(response.body);

    return json
        .map((processo) => ProcessoMinerario.fromJson(processo))
        .toList();
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

  Future<List<ProcessoMinerario>> pesquisar(String termo) async {

    final uri = Uri.parse(
      "${ApiService.baseUrl}/processos/pesquisar",
    ).replace(
      queryParameters: {
        "termo": termo,
      },
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception("Erro ao pesquisar processos.");
    }

    final List<dynamic> json = jsonDecode(response.body);

    return json
        .map((processo) => ProcessoMinerario.fromJson(processo))
        .toList();
  }
}