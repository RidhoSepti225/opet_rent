import 'package:flutter/material.dart';
import 'detail_kendaraan_page.dart';

class PilihMobilPage extends StatelessWidget {
  const PilihMobilPage({super.key});

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
              padding: const EdgeInsets.all(12),

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
                          "Pilih Mobil",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Image.asset("assets/images/logo_opet.png", width: 28),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // SEARCH
                  SizedBox(
                    height: 35,
                    child: TextField(
                      style: const TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        hintText: "Cari Mobil...",

                        hintStyle: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),

                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 18,
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

                  const SizedBox(height: 12),

                  // GRID MOBIL
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: 7,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.9,
                        ),

                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const DetailKendaraanPage(
                                nama: "Toyota Avanza",
                                harga: "Rp.350.000/hari",
                                iconKendaraan: Icons.directions_car,
                              ),
                            ),
                          );
                        },

                        child: Container(
                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),

                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            mainAxisAlignment: MainAxisAlignment.end,

                            children: [
                              Text(
                                "Toyota Avanza",
                                style: TextStyle(
                                  color: Color(0xFF0A6DD9),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),

                              SizedBox(height: 2),

                              Text(
                                "Rp.350.000/hari",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
