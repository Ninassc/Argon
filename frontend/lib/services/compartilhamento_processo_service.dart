import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/compartilhamento_processo.dart';
import 'api_service.dart';

class CompartilhamentoProcessoService {
  Future<void> compartilhar({
    required int idProcesso,
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/compartilhamentos/$idProcesso"),
      headers: await ApiService.authHeaders(),
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 201) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao compartilhar processo.");
    }
  }

  Future<List<CompartilhamentoProcesso>> listarRecebidos() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/compartilhamentos/recebidos"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);

      return json.map((e) => CompartilhamentoProcesso.fromJson(e)).toList();
    }

    final erro = jsonDecode(response.body);

    throw Exception(erro["erro"] ?? "Erro ao listar processos recebidos.");
  }

  Future<List<CompartilhamentoProcesso>> listarEnviados() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/compartilhamentos/enviados"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> json = jsonDecode(response.body);

      return json.map((e) => CompartilhamentoProcesso.fromJson(e)).toList();
    }

    final erro = jsonDecode(response.body);

    throw Exception(erro["erro"] ?? "Erro ao listar processos enviados.");
  }
}
