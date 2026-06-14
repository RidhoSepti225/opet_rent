import 'dart:convert';
import 'package:http/http.dart' as http;

class OnoPayService {
  static const String baseUrl = "https://onopay.web.id/api/v1";

  static Future<Map<String, dynamic>> checkUser(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/merchant/check-user"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> checkBalance(String phoneNumber) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/merchant/check-balance"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> topUp({
    required String phoneNumber,
    required int amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("https://onopay.web.id/api/v1/payment/topup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"phone_number": phoneNumber, "amount": amount}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> payQr({
    required String qrCode,
    required String payerPhone,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("https://onopay.web.id/api/v1/payment/qr/pay"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"qr_code": qrCode, "payer_phone": payerPhone}),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
