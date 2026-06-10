import 'package:flutter/material.dart';
import 'detail_booking_page.dart';
import '../home/home_page.dart';
import '../history/riwayat_booking_page.dart';
import '../profile/profile_page.dart';

class MyBookingPage extends StatelessWidget {
  const MyBookingPage({super.key});

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
                      _bookingCard(
                        context,
                        nama: "Honda Vario 160",
                        status: "Sedang Digunakan",
                        tanggalPinjam: "01/06/2026",
                        tanggalKembali: "05/06/2026",
                        icon: Icons.two_wheeler,
                      ),

                      const SizedBox(height: 12),

                      _bookingCard(
                        context,
                        nama: "Toyota Avanza",
                        status: "Siap Diambil",
                        tanggalPinjam: "10/06/2026",
                        tanggalKembali: "12/06/2026",
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
        currentIndex: 1,

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
            // sedang di halaman booking
          }

          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RiwayatPage()),
            );
          }

          if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfilePage()),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Beranda"),

          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Booking"),

          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: "Riwayat",
          ),

          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget _bookingCard(
    BuildContext context, {
    required String nama,
    required String status,
    required String tanggalPinjam,
    required String tanggalKembali,
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

                Text(
                  "Status : $status",
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
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
                        builder: (_) => const DetailBookingPage(),
                      ),
                    );
                  },

                  child: const Text(
                    "Lihat Detail Kendaraan",
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
