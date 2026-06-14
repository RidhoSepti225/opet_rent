import 'package:flutter/material.dart';
import 'rincian_tagihan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/booking_service.dart';

class DataDiriPage extends StatefulWidget {
  final Map<String, dynamic> kendaraan;
  final int paket;
  final DateTime? tanggalPemakaian;

  const DataDiriPage({
    super.key,
    required this.kendaraan,
    required this.paket,
    required this.tanggalPemakaian,
  });

  @override
  State<DataDiriPage> createState() => _DataDiriPageState();
}

class _DataDiriPageState extends State<DataDiriPage> {
  int selectedJaminan = 1;

  final namaController = TextEditingController();
  final ktpController = TextEditingController();
  final simController = TextEditingController();
  final hpController = TextEditingController();
  final alamatController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    namaController.dispose();
    ktpController.dispose();
    simController.dispose();
    hpController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> submitBooking() async {
    if (namaController.text.trim().isEmpty ||
        ktpController.text.trim().isEmpty ||
        simController.text.trim().isEmpty ||
        hpController.text.trim().isEmpty ||
        alamatController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Semua field wajib diisi")));
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");

    if (userId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Silakan login ulang")));
      return;
    }

    String jaminan = "Kartu Tanda Penduduk";

    if (selectedJaminan == 2) {
      jaminan = "Kartu Keluarga";
    } else if (selectedJaminan == 3) {
      jaminan = "STNK";
    }

    setState(() {
      isLoading = true;
    });

    final result = await BookingService.createBooking(
      userId: userId,
      kendaraanId: widget.kendaraan["id"],
      nama: namaController.text.trim(),
      noKtp: ktpController.text.trim(),
      noSim: simController.text.trim(),
      noHp: hpController.text.trim(),
      alamat: alamatController.text.trim(),
      tanggalPemakaian: widget.tanggalPemakaian!.toIso8601String(),
      jaminan: jaminan,
      paket: widget.paket,
    );

    setState(() {
      isLoading = false;
    });

    if (result["success"] == true) {
      final bookingId = result["booking_id"];

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RincianTagihanPage(
            kendaraan: widget.kendaraan,
            paket: widget.paket,
            bookingId: bookingId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Booking gagal")),
      );
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A6DD9), Color(0xFF4DB8FF)],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),

            child: SingleChildScrollView(
              child: Column(
                children: [
                  // HEADER
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),

                      const Expanded(
                        child: Text(
                          "Data Diri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Image.asset("assets/images/logo_opet.png", width: 28),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Nama Lengkap :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField(
                          "Masukan nama lengkap",
                          controller: namaController,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "No. KTP :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField(
                          "Masukan No. KTP",
                          controller: ktpController,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "No. SIM :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField(
                          "Masukan No. SIM",
                          controller: simController,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "No. Handphone :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField(
                          "Masukan No. Handphone",
                          controller: hpController,
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "Alamat :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField(
                          "Masukan Alamat",
                          controller: alamatController,
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Jaminan (pilih salah satu)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            children: [
                              _jaminanTile(1, "Kartu Tanda Penduduk"),

                              _jaminanTile(2, "Kartu Keluarga"),

                              _jaminanTile(3, "STNK"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          height: 45,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1976F3),
                            ),

                            onPressed: isLoading ? null : submitBooking,

                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                : const Text(
                                    "Lanjut",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _jaminanTile(int value, String title) {
    return RadioListTile<int>(
      activeColor: Colors.white,
      value: value,
      groupValue: selectedJaminan,

      onChanged: (value) {
        setState(() {
          selectedJaminan = value!;
        });
      },

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
