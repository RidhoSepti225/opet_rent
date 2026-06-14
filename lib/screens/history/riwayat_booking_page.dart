import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/booking_service.dart';
import '../home/home_page.dart';
import '../my_booking/my_booking_page.dart';
import '../profile/profile_page.dart';
import '../my_booking/detail_booking_page.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  bool isLoading = true;
  List riwayat = [];

  @override
  void initState() {
    super.initState();
    loadRiwayat();
  }

  Future<void> loadRiwayat() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id") ?? 0;

    final data = await BookingService.getHistory(userId);

    final today = DateTime.now();

    riwayat = data.where((booking) {
      final selesai = DateTime.parse(booking["tanggal_selesai"]);

      return booking["status"] == "ditolak" || selesai.isBefore(today);
    }).toList();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "ditolak":
        return Colors.red;

      case "disetujui":
        return Colors.green;

      case "pending":
        return Colors.orange;

      case "menunggu":
        return Colors.amber;

      default:
        return Colors.blue;
    }
  }

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
                Row(
                  children: [
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
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : riwayat.isEmpty
                      ? const Center(
                          child: Text(
                            "Belum ada riwayat booking",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : ListView.builder(
                          itemCount: riwayat.length,
                          itemBuilder: (context, index) {
                            final booking = riwayat[index];

                            final kendaraan = booking["kendaraan"];

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        "https://opet-rent.web.id/storage/${kendaraan["gambar"]}",
                                        width: 90,
                                        height: 90,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return Container(
                                                width: 90,
                                                height: 90,
                                                color: Colors.grey.shade200,
                                                child: const Icon(Icons.image),
                                              );
                                            },
                                      ),
                                    ),

                                    const SizedBox(width: 12),

                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            kendaraan["nama"],
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),

                                          const SizedBox(height: 5),

                                          Text(
                                            "Tanggal Peminjaman : ${booking["tanggal_mulai"]}",
                                          ),

                                          Text(
                                            "Tanggal Pengembalian : ${booking["tanggal_selesai"]}",
                                          ),

                                          const SizedBox(height: 5),

                                          Text(
                                            "Status : ${booking["status"]}",
                                            style: TextStyle(
                                              color: getStatusColor(
                                                booking["status"],
                                              ),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xFF1976F3,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) =>
                                                      DetailBookingPage(
                                                        booking: booking,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              "Lihat Detail Kendaraan",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
}
