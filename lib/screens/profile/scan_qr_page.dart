import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../services/onopay_service.dart';

class ScanQrPage extends StatefulWidget {
  final String phoneNumber;

  const ScanQrPage({super.key, required this.phoneNumber});

  @override
  State<ScanQrPage> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  bool isProcessing = false;
  bool isShowingConfirmation = false;

  final currency = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  Future<void> processQr(String qrCode) async {
    if (isProcessing) return;

    setState(() {
      isProcessing = true;
    });

    final result = await OnoPayService.payQr(
      qrCode: qrCode,
      payerPhone: widget.phoneNumber,
    );

    if (!mounted) return;

    if (result["success"] == true) {
      final amount = result["data"]["amount"] ?? 0;

      showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.transparent,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 80),

                const SizedBox(height: 15),

                const Text(
                  "Pembayaran Berhasil",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 15),

                Text(
                  currency.format(amount),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A6DD9),
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Transaksi berhasil diproses menggunakan OnoPay",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0A6DD9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    },
                    child: const Text(
                      "Selesai",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Pembayaran gagal")),
      );

      setState(() {
        isProcessing = false;
      });
    }
  }

  Future<void> showPaymentConfirmation(String qrCode) async {
    if (isShowingConfirmation) return;

    isShowingConfirmation = true;

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 50,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              const SizedBox(height: 20),

              const CircleAvatar(
                radius: 35,
                backgroundColor: Color(0xFFEAF3FF),
                child: Icon(Icons.qr_code, size: 35, color: Color(0xFF0A6DD9)),
              ),

              const SizedBox(height: 15),

              const Text(
                "QR Berhasil Dipindai",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Apakah Anda yakin ingin melanjutkan pembayaran menggunakan saldo OnoPay?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Batal"),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A6DD9),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        processQr(qrCode);
                      },
                      child: const Text(
                        "Bayar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );

    isShowingConfirmation = false;
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
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
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
                        "Scan QR OnoPay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 30),

                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.qr_code_scanner,
                    color: Color(0xFF0A6DD9),
                    size: 35,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Arahkan QR ke dalam area scan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "QR akan dipindai secara otomatis",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 30),

                Container(
                  width: 320,
                  height: 320,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      children: [
                        MobileScanner(
                          onDetect: (capture) {
                            final barcode = capture.barcodes.first;

                            final code = barcode.rawValue;

                            if (code != null &&
                                !isProcessing &&
                                !isShowingConfirmation) {
                              showPaymentConfirmation(code);
                            }
                          },
                        ),

                        Center(
                          child: Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFF0A6DD9),
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.white),

                      SizedBox(width: 12),

                      Expanded(
                        child: Text(
                          "Pastikan QR Code terlihat jelas dan berada di dalam kotak scanner.",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                if (isProcessing)
                  const CircularProgressIndicator(color: Colors.white),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
