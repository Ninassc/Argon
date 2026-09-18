import 'package:flutter/material.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/storage/auth_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthStorage _storage = AuthStorage();
  final AuthService _service = AuthService();

  Usuario? usuarioLogado;

  Future<void> buscarUsuario() async {
    usuarioLogado = await _storage.buscarUsuario();
    notifyListeners();
  }

  Future<void> removerToken() async {
    await _storage.removerToken();
    notifyListeners();
  }

  Future<void> fazerLogin(String identificador, String senha) async {
    final resultado = await _service.login(
      identificador: identificador,
      senha: senha,
    );

    await _storage.salvarToken(resultado['token']);
    await _storage.salvarUsuario(resultado['usuario']);

    usuarioLogado = resultado['usuario'];

    notifyListeners();
  }
}
