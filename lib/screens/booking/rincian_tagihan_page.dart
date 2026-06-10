import 'package:flutter/material.dart';
import 'payment_page.dart';

class RincianTagihanPage extends StatelessWidget {
  const RincianTagihanPage({super.key});

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
            padding: const EdgeInsets.all(16),

            child: Column(
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
                        "Rincian Tagihan",
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

                const SizedBox(height: 15),

                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            children: [
                              _itemTagihan("Paket Sewa (hari)", "Rp. xxx.xxx"),

                              const SizedBox(height: 20),

                              _itemTagihan("Biaya Layanan", "Rp. xxx.xxx"),

                              const SizedBox(height: 20),

                              _itemTagihan("Opet", "Rp. xxx.xxx"),

                              const SizedBox(height: 20),

                              Divider(color: Colors.white.withOpacity(0.7)),

                              const SizedBox(height: 15),

                              _itemTagihan(
                                "Total Tagihan",
                                "Rp. xxx.xxx",
                                isBold: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,

                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1976F3),
                    ),

                    onPressed: () {
                      print("TOMBOL DIKLIK");

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const PaymentPage()),
                      );
                    },

                    child: const Text(
                      "Lanjut",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _itemTagihan(
    String title,
    String value, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),

        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
