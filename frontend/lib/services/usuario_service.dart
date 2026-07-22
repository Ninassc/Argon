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

  Future<Usuario> atualizarPerfil({
    required String nome,
    String? email,
    String? telefone,
    required TipoConta tipoConta,
  }) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/usuarios/me"),
      headers: await ApiService.authHeaders(),
      body: jsonEncode({
        "nome": nome,
        "email": email?.trim().isEmpty ?? true ? null : email,
        "telefone": telefone?.trim().isEmpty ?? true ? null : telefone,
        "tipo_conta": tipoConta.name,
      }),
    );

    if (response.statusCode != 200) {
      final erro = jsonDecode(response.body);
      throw Exception(erro["erro"]);
    }

    return Usuario.fromJson(jsonDecode(response.body));
  }

  Future<void> alterarSenha({
    required String senhaAtual,
    required String novaSenha,
    required String confirmarSenha,
  }) async {
    final response = await http.put(
      Uri.parse("${ApiService.baseUrl}/usuarios/me/senha"),
      headers: await ApiService.authHeaders(),
      body: jsonEncode({
        "senha_atual": senhaAtual,
        "nova_senha": novaSenha,
        "confirmar_senha": confirmarSenha,
      }),
    );

    if (response.statusCode != 200) {
      final mensagem = jsonDecode(response.body)["erro"];
      throw Exception(mensagem);
    }
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
