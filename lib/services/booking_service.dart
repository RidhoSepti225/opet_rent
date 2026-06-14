import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingService {
  static const String baseUrl = "https://opet-rent.web.id/api";

  static Future<List<dynamic>> getHistory(int userId) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/booking/history/$userId"),
      );

      final data = jsonDecode(response.body);

      return data["data"] ?? [];
    } catch (e) {
      return [];
    }
  }

  static Future<Map<String, dynamic>> generateQr(int bookingId) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/generate-qr/$bookingId"),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> uploadBukti({
    required int bookingId,
    required String imagePath,
  }) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("$baseUrl/upload-bukti"),
      );

      request.fields['booking_id'] = bookingId.toString();

      request.files.add(await http.MultipartFile.fromPath('bukti', imagePath));

      var response = await request.send();

      var responseBody = await response.stream.bytesToString();

      return jsonDecode(responseBody);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> createBooking({
    required int userId,
    required int kendaraanId,
    required String nama,
    required String noKtp,
    required String noSim,
    required String noHp,
    required String alamat,
    required String tanggalPemakaian,
    required String jaminan,
    required int paket,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/booking"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "user_id": userId,
          "kendaraan_id": kendaraanId,
          "nama": nama,
          "no_ktp": noKtp,
          "no_sim": noSim,
          "no_hp": noHp,
          "alamat": alamat,
          "tanggal_pemakaian": tanggalPemakaian,
          "jaminan": jaminan,
          "paket": paket,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }

  static Future<Map<String, dynamic>> payBookingOnoPay({
    required int bookingId,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/pay-booking-onopay"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "booking_id": bookingId,
          "phone_number": phoneNumber,
        }),
      );

      return jsonDecode(response.body);
    } catch (e) {
      return {"success": false, "message": e.toString()};
    }
  }
}
