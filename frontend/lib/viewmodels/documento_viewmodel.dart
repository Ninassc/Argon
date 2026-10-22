import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import '../services/documento_service.dart';

class DocumentoViewModel extends ChangeNotifier {
  final DocumentoService _service = DocumentoService();

  bool carregando = false;

  Future<Map<String, dynamic>> cadastrar(
    int idAtivo,
    PlatformFile arquivo,
  ) async {
    carregando = true;
    notifyListeners();

    try {
      return await _service.cadastrar(idAtivo, arquivo);
    } finally {
      carregando = false;
      notifyListeners();
    }
  }
}
