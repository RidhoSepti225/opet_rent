import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/booking_service.dart';
import 'status_pembayaran_page.dart';

class QRPaymentPage extends StatefulWidget {
  final int bookingId;
  final int totalTagihan;

  const QRPaymentPage({
    super.key,
    required this.bookingId,
    required this.totalTagihan,
  });

  @override
  State<QRPaymentPage> createState() => _QRPaymentPageState();
}

class _QRPaymentPageState extends State<QRPaymentPage> {
  bool isLoading = true;
  bool isUploading = false;

  String? qrImage;
  File? buktiImage;

  @override
  void initState() {
    super.initState();
    loadQr();
  }

  Future<void> loadQr() async {
    final result = await BookingService.generateQr(widget.bookingId);

    if (mounted) {
      setState(() {
        qrImage = result["qr_image"];
        isLoading = false;
      });
    }
  }

  Future<void> pilihGambar() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        buktiImage = File(image.path);
      });
    }
  }

  Future<void> uploadBukti() async {
    if (buktiImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pilih bukti pembayaran terlebih dahulu")),
      );
      return;
    }

    setState(() {
      isUploading = true;
    });

    final result = await BookingService.uploadBukti(
      bookingId: widget.bookingId,
      imagePath: buktiImage!.path,
    );

    setState(() {
      isUploading = false;
    });

    if (result["success"] == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) =>
              StatusPembayaranPage(bookingId: widget.bookingId, metode: "QRIS"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result["message"] ?? "Upload gagal")),
      );
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
                        "QR Pembayaran",
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

                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Invoice",
                            style: TextStyle(color: Colors.white70),
                          ),

                          const SizedBox(height: 5),

                          Text(
                            "INV-OPET-${widget.bookingId}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "Rp ${widget.totalTagihan}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 25),

                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : qrImage != null
                                ? Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.network(
                                      qrImage!,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : const Center(child: Text("QR gagal dimuat")),
                          ),

                          const SizedBox(height: 20),

                          ElevatedButton(
                            onPressed: pilihGambar,
                            child: const Text("Pilih Bukti Pembayaran"),
                          ),

                          const SizedBox(height: 10),

                          if (buktiImage != null)
                            Container(
                              height: 180,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.file(buktiImage!, fit: BoxFit.cover),
                            ),

                          const SizedBox(height: 20),

                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: isUploading ? null : uploadBukti,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF1976F3),
                              ),
                              child: isUploading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text(
                                      "Upload Bukti Pembayaran",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
