import 'package:flutter/material.dart';

class UbahPasswordPage extends StatelessWidget {
  const UbahPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0A6DD9), Color(0xFF4DB8FF)],
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

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
                        "Ubah Kata Sandi",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Image.asset("assets/images/logo_opet.png", width: 30),
                  ],
                ),

                const SizedBox(height: 30),

                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,

                  child: Icon(Icons.lock, size: 75, color: Color(0xFF0A6DD9)),
                ),

                const SizedBox(height: 30),

                _buildPasswordField(
                  label: "Password Lama",
                  hint: "Masukkan Password Lama",
                ),

                const SizedBox(height: 15),

                _buildPasswordField(
                  label: "Password Baru",
                  hint: "Masukkan Password Baru",
                ),

                const SizedBox(height: 15),

                _buildPasswordField(
                  label: "Konfirmasi Password Baru",
                  hint: "Ulangi Password Baru",
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Kata sandi berhasil diperbarui"),
                        ),
                      );
                    },

                    child: const Text(
                      "Simpan Perubahan",
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
    );
  }

  static Widget _buildPasswordField({
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),

        const SizedBox(height: 4),

        TextField(
          obscureText: true,

          decoration: InputDecoration(
            hintText: hint,

            filled: true,
            fillColor: Colors.white,

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
