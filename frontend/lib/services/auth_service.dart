import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/usuario.dart';
import 'api_service.dart';

class AuthService {
  Future<Map<String, dynamic>> login({
    required String identificador,
    required String senha,
  }) async {
    
    final response = await http.post(
      Uri.parse("${ApiService.baseUrl}/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"identificador": identificador, "senha": senha}),
    );

    if (response.statusCode != 200) {
      throw Exception("Credenciais inválidas.");
    }

    final json = jsonDecode(response.body);

    return {
      "token": json["token"],
      "usuario": Usuario.fromJson(json["usuario"]),
    };
  }
}
