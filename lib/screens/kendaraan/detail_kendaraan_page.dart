import 'package:flutter/material.dart';
import '../booking/data_diri_page.dart';

class DetailKendaraanPage extends StatefulWidget {
  final Map<String, dynamic> kendaraan;

  const DetailKendaraanPage({super.key, required this.kendaraan});

  @override
  State<DetailKendaraanPage> createState() => _DetailKendaraanPageState();
}

class _DetailKendaraanPageState extends State<DetailKendaraanPage> {
  int selectedPaket = 1;
  DateTime? tanggalPemakaian;

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
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "Detail Kendaraan",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      Image.asset('assets/images/logo_opet.png', width: 30),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ICON KENDARAAN
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),

                      child: Image.network(
                        "https://opet-rent.web.id/storage/${widget.kendaraan["gambar"]}",

                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,

                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 120,
                            color: Colors.white,
                          );
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    widget.kendaraan["nama"],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "Rp ${double.parse(widget.kendaraan["harga_sewa"]).toInt()}/hari",
                    style: const TextStyle(color: Colors.white70, fontSize: 18),
                  ),

                  const SizedBox(height: 20),

                  Text(
                    "• CC : ${widget.kendaraan["cc"]}",
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Tahun : ${widget.kendaraan["tahun"]}",
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Transmisi : ${widget.kendaraan["transmisi"]}",
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    "• Warna : ${widget.kendaraan["warna"]}",
                    style: const TextStyle(color: Colors.white),
                  ),

                  const SizedBox(height: 10),

                  Divider(color: Colors.white.withValues(alpha: 0.5)),

                  const SizedBox(height: 10),

                  const Text(
                    "Tanggal Pemakaian",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  SizedBox(
                    width: double.infinity,

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),

                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2030),
                        );

                        if (picked != null) {
                          setState(() {
                            tanggalPemakaian = picked;
                          });
                        }
                      },

                      child: Text(
                        tanggalPemakaian == null
                            ? "Pilih Tanggal"
                            : "${tanggalPemakaian!.day}/${tanggalPemakaian!.month}/${tanggalPemakaian!.year}",
                        style: const TextStyle(color: Color(0xFF0A6DD9)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Pilih Paket Sewa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        _paketTile(
                          1,
                          "1 Hari",
                          "Rp ${double.parse(widget.kendaraan["harga_sewa"]).toInt()}",
                        ),

                        _paketTile(
                          2,
                          "2 Hari",
                          "Rp ${(double.parse(widget.kendaraan["harga_sewa"]) * 2).toInt()}",
                        ),

                        _paketTile(
                          3,
                          "3 Hari",
                          "Rp ${(double.parse(widget.kendaraan["harga_sewa"]) * 3).toInt()}",
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1976F3),
                      ),

                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DataDiriPage(
                              kendaraan: widget.kendaraan,
                              paket: selectedPaket,
                              tanggalPemakaian: tanggalPemakaian,
                            ),
                          ),
                        );
                      },

                      child: const Text(
                        "Booking Sekarang",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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

  Widget _paketTile(int value, String title, String harga) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Radio<int>(
            value: value,
            groupValue: selectedPaket,
            activeColor: Colors.white,
            onChanged: (value) {
              setState(() {
                selectedPaket = value!;
              });
            },
          ),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Text(
            harga,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
