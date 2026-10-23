import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

import '../models/documento.dart';
import '../services/documento_service.dart';

class DocumentoViewModel extends ChangeNotifier {
  final DocumentoService _service = DocumentoService();

  bool carregando = false;
  bool carregandoDocumentos = false;
  bool carregandoBaixar = false;

  List<Documento> documentos = [];

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

  Future<void> listarPorAtivo(int idAtivo) async {
    carregandoDocumentos = true;
    notifyListeners();

    documentos = [];

    try {
      documentos = await _service.listarPorAtivo(idAtivo);
    } finally {
      carregandoDocumentos = false;
      notifyListeners();
    }
  }

  Future<Uint8List> baixar(int idDocumento) async {
    carregandoBaixar = true;
    notifyListeners();

    try {
      return await _service.baixar(idDocumento);
    } finally {
      carregandoBaixar = false;
      notifyListeners();
    }
  }
}
