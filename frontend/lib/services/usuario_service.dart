import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/usuario.dart';
import 'api_service.dart';

class UsuarioService {
  Future<List<Usuario>> listar() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/usuarios/"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar usuários.");
    }

    final List<dynamic> json = jsonDecode(response.body);

    return json.map((usuario) => Usuario.fromJson(usuario)).toList();
  }

  Future<Usuario> buscarPorId(int idUsuario) async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/usuarios/$idUsuario"),
    );

    if (response.statusCode == 404) {
      throw Exception("Usuário não encontrado.");
    }

    if (response.statusCode != 200) {
      throw Exception("Erro ao buscar usuário.");
    }

    final json = jsonDecode(response.body);

    return Usuario.fromJson(json);
  }

  Future<Usuario> criar(Usuario usuario) async {
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/usuarios/"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Erro ao criar usuário.");
    }

    final json = jsonDecode(response.body);

    return Usuario.fromJson(json);
  }

  Future<Usuario> atualizar(int idUsuario, Usuario usuario) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/usuarios/$idUsuario"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao atualizar usuário.");
    }

    final json = jsonDecode(response.body);

    return Usuario.fromJson(json);
  }

  Future<void> deletar(int idUsuario) async {
    final response = await http.delete(
      Uri.parse("${ApiService.baseUrl}/usuarios/$idUsuario"),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao excluir usuário.");
    }
  }

  Future<Usuario> buscarPerfil() async {
    final response = await http.get(
      Uri.parse("${ApiService.baseUrl}/usuarios/me"),
      headers: await ApiService.authHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception("Erro ao carregar perfil.");
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }
}
