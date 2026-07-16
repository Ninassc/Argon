import 'package:frontend/storage/auth_storage.dart';

class ApiService {
  static const String baseUrl = "http://localhost:5000";

  static Future<Map<String, String>> authHeaders() async {
    final token = await AuthStorage().buscarToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
