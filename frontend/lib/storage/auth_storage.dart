import 'package:shared_preferences/shared_preferences.dart';

class AuthStorage {
  static const _tokenKey = "token";

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
  }

  Future<bool> estaLogado() async {
    final token = await buscarToken();

    return token != null;
  }
}
