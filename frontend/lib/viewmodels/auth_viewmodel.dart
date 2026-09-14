import 'package:flutter/material.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/storage/auth_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthStorage _storage = AuthStorage();

  Usuario? usuarioLogado;

  Future<void> buscarUsuario() async {
    usuarioLogado = await _storage.buscarUsuario();
    notifyListeners();
  }
}
