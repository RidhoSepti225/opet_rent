import 'package:flutter/material.dart';
import '../home/home_page.dart';

class StatusPembayaranPage extends StatelessWidget {
  final int bookingId;
  final String metode;

  const StatusPembayaranPage({
    super.key,
    required this.bookingId,
    required this.metode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnoPay = metode == "OnoPay";

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
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Status Pembayaran",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset("assets/images/logo_opet.png", width: 30),
                  ],
                ),

                const Spacer(),

                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  child: Icon(
                    isOnoPay ? Icons.account_balance_wallet : Icons.check,
                    color: Colors.white,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  isOnoPay
                      ? "Pembayaran OnoPay Berhasil"
                      : "Bukti Pembayaran Terkirim",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Invoice OPET-$bookingId berhasil diproses.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),

                const SizedBox(height: 35),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Status Pembayaran",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Menunggu Verifikasi",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Status Booking",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "Menunggu Persetujuan",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 18),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Metode",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            metode,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  isOnoPay
                      ? "Pembayaran berhasil dilakukan menggunakan saldo OnoPay. Admin akan memverifikasi booking Anda sebelum kendaraan dapat digunakan."
                      : "Admin akan memverifikasi bukti pembayaran dan booking Anda. Silakan cek menu Booking atau Riwayat secara berkala.",
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "Kembali ke Beranda",
                      style: TextStyle(
                        color: Color(0xFF0A6DD9),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
}
