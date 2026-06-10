import 'package:flutter/material.dart';

import 'edit_profile_page.dart';
import 'ubah_password_page.dart';

class PengaturanAkunPage extends StatelessWidget {
  const PengaturanAkunPage({super.key});

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
                        "Pengaturan Akun",
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

                const SizedBox(height: 25),

                // ICON
                const CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.white,

                  child: Icon(
                    Icons.settings,
                    size: 70,
                    color: Color(0xFF0A6DD9),
                  ),
                ),

                const SizedBox(height: 35),

                // EDIT PROFIL
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.person, color: Color(0xFF0A6DD9)),

                    label: const Text(
                      "Edit Profil",
                      style: TextStyle(
                        color: Color(0xFF0A6DD9),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // UBAH PASSWORD
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),

                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UbahPasswordPage(),
                        ),
                      );
                    },

                    icon: const Icon(Icons.lock, color: Color(0xFF0A6DD9)),

                    label: const Text(
                      "Ubah Kata Sandi",
                      style: TextStyle(
                        color: Color(0xFF0A6DD9),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
