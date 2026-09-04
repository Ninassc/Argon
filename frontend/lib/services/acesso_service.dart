import 'dart:convert';

import '../models/acesso.dart';
import 'api_service.dart';

import 'package:http/http.dart' as http;

class AcessoService {
  Future<Acesso> solicitar(int idAtivo) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/acessos/$idAtivo/solicitar"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 201) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao solicitar acesso.");
    }

    final json = jsonDecode(response.body);

    return Acesso.fromJson(json);
  }

  Future<List<Acesso>> listarRecebidas() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/acessos/recebidas"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao listar solicitações de acesso.");
    }

    final List<dynamic> listaJsons = jsonDecode(response.body);

    final recebidos = listaJsons.map((json) {
      return Acesso.fromJson(json);
    }).toList();

    return recebidos;
  }

  Future<List<Acesso>> listarHistoricoRecebido() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/acessos/historico"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao listar histórico de solicitações de acesso.");
    }

    final List<dynamic> listaJsons = jsonDecode(response.body);

    final recebidos = listaJsons.map((json) {
      return Acesso.fromJson(json);
    }).toList();

    return recebidos;
  }

   Future<List<Acesso>> listarEnviadas() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/acessos/enviadas"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao listar solicitações de acesso enviadas");
    }

    final List<dynamic> listaJsons = jsonDecode(response.body);

    final enviadas = listaJsons.map((json) {
      return Acesso.fromJson(json);
    }).toList();

    return enviadas;
  }

  Future<Acesso> aprovar(int idAcesso) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/acessos/$idAcesso/aprovar"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao aprovar acesso.");
    }

    final json = jsonDecode(response.body);

    return Acesso.fromJson(json);
  }

  Future<Acesso> recusar(int idAcesso) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/acessos/$idAcesso/recusar"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao recusar acesso.");
    }

    final json = jsonDecode(response.body);

    return Acesso.fromJson(json);
  }

  Future<Map<String, dynamic>> verificar(int idAtivo) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/acessos/$idAtivo/verificar"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao verificar acesso.");
    }

    final json = jsonDecode(response.body);

    return json;
  }
}
