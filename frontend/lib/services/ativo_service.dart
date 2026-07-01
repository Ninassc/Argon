import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/ativo_minerario.dart';
import 'api_service.dart';

class AtivoService {

  Future<List<AtivoMinerario>> listar(int idUsuario) async {

    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/usuarios/$idUsuario/ativos"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar ativos.");
    }

    final List<dynamic> json = jsonDecode(response.body);

    return json
        .map((ativo) => AtivoMinerario.fromJson(ativo))
        .toList();
  }

  Future<AtivoMinerario> buscar(
    int idUsuario,
    int idAtivo,
  ) async {

    final response = await http.get(
      Uri.parse(
        "${ApiService.baseUrl}/usuarios/$idUsuario/ativos/$idAtivo",
      ),
    );

    if (response.statusCode == 404) {
      throw Exception("Ativo não encontrado.");
    }

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar ativo.");
    }

    final json = jsonDecode(response.body);

    return AtivoMinerario.fromJson(json);
  }

  Future<AtivoMinerario> criar(
    AtivoMinerario ativo,
  ) async {

    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/ativos/"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(ativo.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erro ao criar ativo.");
    }

    final json = jsonDecode(response.body);

    return AtivoMinerario.fromJson(json);
  }

  Future<AtivoMinerario> atualizar(
    int idAtivo,
    AtivoMinerario ativo,
  ) async {

    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/ativos/$idAtivo"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(ativo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar ativo.");
    }

    final json = jsonDecode(response.body);

    return AtivoMinerario.fromJson(json);
  }

  Future<void> deletar(
    int idAtivo,
    int idUsuario,
  ) async {

    final response = await http.delete(
      Uri.parse("${ApiService.baseUrl}/ativos/$idAtivo"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "id_usuario": idUsuario,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir ativo.");
    }
  }
}