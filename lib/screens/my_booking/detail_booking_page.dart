import 'package:flutter/material.dart';

class DetailBookingPage extends StatelessWidget {
  const DetailBookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,

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
                crossAxisAlignment: CrossAxisAlignment.start,

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
                          "Detail Kendaraan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Image.asset("assets/images/logo_opet.png", width: 30),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // GAMBAR KENDARAAN
                  const Center(
                    child: Icon(
                      Icons.two_wheeler,
                      color: Colors.white,
                      size: 140,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Honda Vario 160",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  const Text(
                    "Rp.150.000/hari",
                    style: TextStyle(color: Colors.white70, fontSize: 18),
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
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Tahun Produksi",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Tipe Transmisi Kendaraan",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Kondisi Terawat",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  const Text(
                    "• Dll",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 20),

                  Divider(color: Colors.white.withOpacity(0.5)),

                  const SizedBox(height: 20),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "Informasi Booking",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        SizedBox(height: 12),

                        Text(
                          "Tanggal Peminjaman : 01/06/2026",
                          style: TextStyle(color: Colors.white),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Tanggal Pengembalian : 05/06/2026",
                          style: TextStyle(color: Colors.white),
                        ),

                        SizedBox(height: 6),

                        Text(
                          "Status : Sedang Digunakan",
                          style: TextStyle(
                            color: Colors.greenAccent,
                            fontWeight: FontWeight.bold,
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
}
