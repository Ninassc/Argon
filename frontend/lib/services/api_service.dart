import 'package:frontend/storage/auth_storage.dart';

class ApiService {
  // static const String baseUrl = "http://localhost:5000";
  static const String baseUrl = "https://argon-production-dc27.up.railway.app";

  static Future<Map<String, String>> authHeaders() async {
    final token = await AuthStorage().buscarToken();

    return {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };
  }
}
