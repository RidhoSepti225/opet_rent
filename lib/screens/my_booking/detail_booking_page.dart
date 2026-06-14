import 'package:flutter/material.dart';

class DetailBookingPage extends StatelessWidget {
  final Map<String, dynamic> booking;
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "pending":
        return Colors.orange;

      case "menunggu":
        return Colors.amber;

      case "disetujui":
        return Colors.greenAccent;

      case "ditolak":
        return Colors.red;

      default:
        return Colors.white;
    }
  }

  const DetailBookingPage({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final kendaraan = booking["kendaraan"];

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

                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        "https://opet-rent.web.id/storage/${kendaraan["gambar"]}",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 120,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  Text(
                    kendaraan["nama"] ?? "-",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Rp ${double.parse(kendaraan["harga_sewa"].toString()).toInt()}/hari",
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

                  Text(
                    "• CC : ${kendaraan["cc"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Tahun : ${kendaraan["tahun"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Transmisi : ${kendaraan["transmisi"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Warna : ${kendaraan["warna"]}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Informasi Booking",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          "Tanggal Peminjaman : ${booking["tanggal_mulai"]}",
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Tanggal Pengembalian : ${booking["tanggal_selesai"]}",
                          style: const TextStyle(color: Colors.white),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          "Status : ${booking["status"]}",
                          style: TextStyle(
                            color: getStatusColor(booking["status"]),
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
