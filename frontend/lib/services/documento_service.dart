import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

import 'api_service.dart';

class DocumentoService {
  Future<Map<String, dynamic>> cadastrar(
    int idAtivo,
    PlatformFile arquivo,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiService.baseUrl}/ativos/$idAtivo/documentos"),
    );

    final headers = await ApiService.authHeaders();

    request.headers.addAll(headers);
    request.headers.remove('Content-Type');
    request.headers.remove('content-type');

    if (arquivo.path == null) {
      throw Exception("Não foi possível acessar o arquivo selecionado.");
    }

    request.files.add(
      await http.MultipartFile.fromPath(
        'arquivo',
        arquivo.path!,
        filename: arquivo.name,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      final json = jsonDecode(response.body);

      throw Exception(json["erro"] ?? "Erro ao cadastrar documento.");
    }

    final json = jsonDecode(response.body);

    return json;
  }
}
