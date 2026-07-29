import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/favorito.dart';
import 'api_service.dart';

class FavoritoService {
  Future<Favorito> criar(int idProcesso) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/favoritos/"),
      headers: await ApiService.authHeaders(),
      body: jsonEncode({"id_processo": idProcesso}),
    );

    if (response.statusCode != 201) {
      final erro = jsonDecode(response.body)["erro"];
      throw Exception(erro);
    }

    return Favorito.fromJson(jsonDecode(response.body));
  }

  Future<void> remover(int idProcesso) async {
    final response = await http.delete(
      Uri.parse("${ApiService.baseUrl}/favoritos/$idProcesso"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final erro = jsonDecode(response.body)["erro"];
      throw Exception(erro);
    }
  }

  Future<List<Favorito>> listar() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/favoritos/"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      final erro = jsonDecode(response.body)["erro"];
      throw Exception(erro);
    }

    final List<dynamic> json = jsonDecode(response.body);

    return json.map((favorito) => Favorito.fromJson(favorito)).toList();
  }

  Future<bool> verificar(int idProcesso) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/favoritos/verificar/$idProcesso"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao verificar favorito.");
    }

    final json = jsonDecode(response.body);

    return json["salvo"];
  }
}
