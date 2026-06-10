import 'package:flutter/material.dart';
import '../booking/data_diri_page.dart';

class DetailKendaraanPage extends StatefulWidget {
  final String nama;
  final String harga;
  final IconData iconKendaraan;

  const DetailKendaraanPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.iconKendaraan,
  });

  @override
  State<DetailKendaraanPage> createState() => _DetailKendaraanPageState();
}

class _DetailKendaraanPageState extends State<DetailKendaraanPage> {
  int selectedPaket = 1;

  @override
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // HEADER
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),

                      const Expanded(
                        child: Text(
                          "Detail Kendaraan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Image.asset('assets/images/logo_opet.png', width: 30),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ICON KENDARAAN
                  Center(
                    child: Icon(
                      widget.iconKendaraan,
                      size: 140,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    widget.harga,
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Spesifikasi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    "• Kapasitas Mesin",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Tahun Produksi",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Tipe Transmisi Kendaraan",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Kondisi Terawat",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 10),

                  Divider(color: Colors.white.withValues(alpha: 0.5)),

                  const SizedBox(height: 10),

                  const Text(
                    "Pilih Paket Sewa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _paketTile(1, "1 Hari", "Rp. xxx"),
                        _paketTile(2, "2 Hari", "Rp. xxx"),
                        _paketTile(3, "3 Hari", "Rp. xxx"),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976F3),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DataDiriPage()),
                        );
                      },

                      child: const Text(
                        "Booking Sekarang",
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
          ),
        ),
      ),
    );
  }

  Widget _paketTile(int value, String title, String harga) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: selectedPaket,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                selectedPaket = value!;
              });
            },
          ),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(
            harga,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
