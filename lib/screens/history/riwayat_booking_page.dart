import 'package:flutter/material.dart';
import '../home/home_page.dart';
import '../kendaraan/detail_kendaraan_page.dart';
import '../profile/profile_page.dart';
import '../my_booking/my_booking_page.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

            child: Column(
              children: [
                // HEADER
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          "OPET",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1,
                          ),
                        ),

                        SizedBox(height: 2),

                        Text(
                          "OPTIMAL PERFORMA EKSPRES TRANSPORT",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Image.asset('assets/images/logo_opet.png', width: 32),
                  ],
                ),

                const SizedBox(height: 4),

                Divider(color: Colors.white.withOpacity(0.4), thickness: 1),

                const SizedBox(height: 10),

                Expanded(
                  child: ListView(
                    children: [
                      _riwayatCard(
                        context,
                        nama: "Honda Vario 160",
                        tanggalPinjam: "01/05/2026",
                        tanggalKembali: "05/05/2026",
                        rating: 5,
                        icon: Icons.two_wheeler,
                      ),

                      const SizedBox(height: 12),

                      _riwayatCard(
                        context,
                        nama: "Toyota Avanza",
                        tanggalPinjam: "10/05/2026",
                        tanggalKembali: "12/05/2026",
                        rating: 4,
                        icon: Icons.directions_car,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFF0A6DD9),

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyBookingPage()),
            );
          }

          if (index == 2) {}

          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),

          BottomNavigationBarItem(icon: Icon(Icons.book), label: "My Booking"),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Riwayat",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _riwayatCard(
    BuildContext context, {
    required String nama,
    required String tanggalPinjam,
    required String tanggalKembali,
    required int rating,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),

      child: Row(
        children: [
          Container(
            width: 90,
            height: 90,

            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),

            child: Icon(icon, size: 50, color: const Color(0xFF0A6DD9)),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

                const SizedBox(height: 5),

                Text("Tanggal Peminjaman : $tanggalPinjam"),

                Text("Tanggal Pengembalian : $tanggalKembali"),

                const SizedBox(height: 5),

                const Text(
                  "Status : SELESAI",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: List.generate(
                    rating,
                    (index) =>
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                  ),
                ),

                const SizedBox(height: 8),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976F3),
                  ),

                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const DetailKendaraanPage(
                          nama: "Honda Vario 160",
                          harga: "Rp.150.000/hari",
                          iconKendaraan: Icons.two_wheeler,
                        ),
                      ),
                    );
                  },

                  child: const Text(
                    "Booking Ulang",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
