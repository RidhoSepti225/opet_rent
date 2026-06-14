import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://opet-rent.web.id/api";

  static Future<List<dynamic>> getKendaraan() async {
    final response = await http.get(Uri.parse("$baseUrl/kendaraan"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data["data"];
    }

    throw Exception("Gagal mengambil data kendaraan");
  }
}
