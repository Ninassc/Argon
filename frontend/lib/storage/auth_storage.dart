import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/usuario.dart';

class AuthStorage {
  static const _tokenKey = "token";
  static const _usuarioKey = "usuario";

  Future<void> salvarToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_tokenKey, token);
  }

  Future<String?> buscarToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(_tokenKey);
  }

  Future<void> removerToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
    await prefs.remove(_usuarioKey);
  }

  Future<bool> estaLogado() async {
    final token = await buscarToken();

    return token != null;
  }

  Future<void> salvarUsuario(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(_usuarioKey, jsonEncode(usuario.toJson()));
  }

  Future<Usuario?> buscarUsuario() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_usuarioKey);

    if (json == null) {
      return null;
    }

    return Usuario.fromJson(jsonDecode(json));
  }
}
