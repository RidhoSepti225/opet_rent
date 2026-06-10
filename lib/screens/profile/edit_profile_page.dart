import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

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
                        "Edit Profil",
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

                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.white,

                  child: Icon(Icons.person, size: 80, color: Color(0xFF0A6DD9)),
                ),

                const SizedBox(height: 30),

                _buildField(
                  label: "Nama Pengguna",
                  hint: "Masukkan Nama Pengguna",
                ),

                const SizedBox(height: 15),

                _buildField(
                  label: "No. Whatsapp",
                  hint: "Masukkan No. Whatsapp",
                ),

                const SizedBox(height: 15),

                _buildField(label: "Username", hint: "Masukkan Username"),

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
                          content: Text("Profil berhasil diperbarui"),
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

  static Widget _buildField({required String label, required String hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),

        const SizedBox(height: 4),

        TextField(
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
