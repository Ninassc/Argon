import 'package:flutter/material.dart';
import 'package:frontend/models/usuario.dart';
import 'package:frontend/services/usuario_service.dart';

class UsuarioViewModel extends ChangeNotifier {
  final UsuarioService _service = UsuarioService();

  Usuario? usuario;
  bool carregando = false;

  Usuario? usuarioVisitado;
  bool carregandoUsuarioVisitado = false;

  Future<void> cadastrar(Usuario usuario) async {
    await _service.criar(usuario);
    notifyListeners();
  }

  Future<void> buscarPerfil() async {
    carregando = true;
    notifyListeners();

    try {
      usuario = await _service.buscarPerfil();
    } finally {
      carregando = false;
      notifyListeners();
    }
  }

  Future<void> buscarUsuarioPorId(int idUsuario) async {
    carregandoUsuarioVisitado = true;
    notifyListeners();

    try {
      usuarioVisitado = await _service.buscarPorId(idUsuario);
    } finally {
      carregandoUsuarioVisitado = false;
      notifyListeners();
    }
  }

  Future<void> atualizarPerfil({
    required String nome,
    required String email,
    required String telefone,
    required TipoConta tipoConta,
  }) async {
    await _service.atualizarPerfil(
      nome: nome,
      email: email,
      telefone: telefone,
      tipoConta: tipoConta,
    );

    await buscarPerfil();
  }

  Future<void> alterarSenha({
    required String senhaAtual,
    required String novaSenha,
    required String confirmarSenha,
  }) async {
    await _service.alterarSenha(
      senhaAtual: senhaAtual,
      novaSenha: novaSenha,
      confirmarSenha: confirmarSenha,
    );
  }
}
