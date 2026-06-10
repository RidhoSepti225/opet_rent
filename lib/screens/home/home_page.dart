import 'package:flutter/material.dart';
import '../kendaraan/pilih_motor_page.dart';
import '../kendaraan/pilih_mobil_page.dart';
import '../kendaraan/detail_kendaraan_page.dart';
import '../my_booking/my_booking_page.dart';
import '../history/riwayat_booking_page.dart';
import '../profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A6DD9),

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
              crossAxisAlignment: CrossAxisAlignment.start,

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

                Divider(
                  color: Colors.white.withValues(alpha: 0.4),
                  thickness: 1,
                ),

                const SizedBox(height: 10),

                // BANNER
                Container(
                  width: double.infinity,
                  height: 85,

                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF42B7FF), Color(0xFF0A6DD9)],
                    ),

                    borderRadius: BorderRadius.circular(8),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 5,
                      ),
                    ],
                  ),

                  child: const Align(
                    alignment: Alignment.centerLeft,

                    child: Text(
                      "Solusi Transportasi Anda,\nCepat & Terpercaya",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // SEARCH
                SizedBox(
                  height: 28,

                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 11),

                    decoration: InputDecoration(
                      hintText: "Cari Kendaraan...",

                      hintStyle: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                      ),

                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 16,
                      ),

                      contentPadding: EdgeInsets.zero,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),

                        borderSide: const BorderSide(color: Colors.white),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),

                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // MENU
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PilihMotorPage(),
                          ),
                        );
                      },
                      child: _menuCard(Icons.two_wheeler, "Motor"),
                    ),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PilihMobilPage(),
                          ),
                        );
                      },
                      child: _menuCard(Icons.directions_car, "Mobil"),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                const Text(
                  "Rekomendasi",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),

                    itemCount: 6,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.2,
                        ),

                    itemBuilder: (context, index) {
                      final kendaraan = [
                        {
                          "nama": "Honda Vario 160",
                          "harga": "Rp.150.000/hari",
                          "icon": Icons.two_wheeler,
                        },
                        {
                          "nama": "Toyota Avanza",
                          "harga": "Rp.350.000/hari",
                          "icon": Icons.directions_car,
                        },
                        {
                          "nama": "Yamaha NMAX",
                          "harga": "Rp.180.000/hari",
                          "icon": Icons.two_wheeler,
                        },
                        {
                          "nama": "Toyota Innova",
                          "harga": "Rp.450.000/hari",
                          "icon": Icons.directions_car,
                        },
                        {
                          "nama": "Honda PCX",
                          "harga": "Rp.170.000/hari",
                          "icon": Icons.two_wheeler,
                        },
                        {
                          "nama": "Mitsubishi Xpander",
                          "harga": "Rp.400.000/hari",
                          "icon": Icons.directions_car,
                        },
                      ];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailKendaraanPage(
                                nama: kendaraan[index]["nama"] as String,
                                harga: kendaraan[index]["harga"] as String,
                                iconKendaraan:
                                    kendaraan[index]["icon"] as IconData,
                              ),
                            ),
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              Text(
                                kendaraan[index]["nama"] as String,
                                style: const TextStyle(
                                  color: Color(0xFF0A6DD9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 2),

                              Text(
                                kendaraan[index]["harga"] as String,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
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
        currentIndex: 0,

        type: BottomNavigationBarType.fixed,

        selectedItemColor: const Color(0xFF0A6DD9),

        unselectedItemColor: Colors.grey,

        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyBookingPage()),
            );
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

  Widget _menuCard(IconData icon, String title) {
    return Container(
      width: 62,
      height: 62,

      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 1),

        borderRadius: BorderRadius.circular(6),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Icon(icon, color: Colors.white, size: 22),

          const SizedBox(height: 2),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
