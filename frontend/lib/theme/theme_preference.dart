import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciaTema extends ChangeNotifier {
  static const _chave = 'theme_mode';

  PreferenciaTema(this._preferencias);

  final SharedPreferences _preferencias;

  ThemeMode get modo => switch (_preferencias.getString(_chave)) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };

  Future<void> alterar(ThemeMode novoModo) async {
    if (modo == novoModo) return;
    final salvamento = _preferencias.setString(_chave, novoModo.name);
    notifyListeners();
    if (!await salvamento) {
      throw StateError('Não foi possível salvar o tema.');
    }
  }
}
