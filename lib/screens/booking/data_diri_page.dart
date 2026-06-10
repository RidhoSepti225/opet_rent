import 'package:flutter/material.dart';
import 'rincian_tagihan_page.dart';

class DataDiriPage extends StatefulWidget {
  const DataDiriPage({super.key});

  @override
  State<DataDiriPage> createState() => _DataDiriPageState();
}

class _DataDiriPageState extends State<DataDiriPage> {
  int selectedJaminan = 1;

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

            child: SingleChildScrollView(
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
                          "Data Diri",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      Image.asset("assets/images/logo_opet.png", width: 28),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        const Text(
                          "Nama Lengkap :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField("Masukan nama lengkap"),

                        const SizedBox(height: 10),

                        const Text(
                          "No. KTP :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField("Masukan No. KTP"),

                        const SizedBox(height: 10),

                        const Text(
                          "No. SIM :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField("Masukan No. SIM"),

                        const SizedBox(height: 10),

                        const Text(
                          "No. Handphone :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField("Masukan No. Handphone"),

                        const SizedBox(height: 10),

                        const Text(
                          "Alamat :",
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        const SizedBox(height: 4),

                        _buildTextField("Masukan Alamat"),

                        const SizedBox(height: 18),

                        const Text(
                          "Jaminan (pilih salah satu)",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            children: [
                              _jaminanTile(1, "Kartu Tanda Penduduk"),

                              _jaminanTile(2, "Kartu Keluarga"),

                              _jaminanTile(3, "STNK"),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

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
                                  builder: (_) => const RincianTagihanPage(),
                                ),
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
                      ],
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

  Widget _buildTextField(String hint) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,

        filled: true,
        fillColor: Colors.white,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _jaminanTile(int value, String title) {
    return RadioListTile<int>(
      activeColor: Colors.white,
      value: value,
      groupValue: selectedJaminan,

      onChanged: (value) {
        setState(() {
          selectedJaminan = value!;
        });
      },

      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
