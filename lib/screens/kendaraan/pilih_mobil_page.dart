import 'package:flutter/material.dart';

import '../../services/api_service.dart';
import 'detail_kendaraan_page.dart';

class PilihMobilPage extends StatefulWidget {
  const PilihMobilPage({super.key});

  @override
  State<PilihMobilPage> createState() => _PilihMobilPageState();
}

class _PilihMobilPageState extends State<PilihMobilPage> {
  List<dynamic> semuaMobil = [];
  List<dynamic> mobilFiltered = [];

  @override
  void initState() {
    super.initState();
    loadMobil();
  }

  Future<void> loadMobil() async {
    try {
      final data = await ApiService.getKendaraan();

      final mobil = data.where((item) {
        return item["jenis"].toString().toLowerCase() == "mobil";
      }).toList();

      setState(() {
        semuaMobil = mobil;
        mobilFiltered = mobil;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void searchMobil(String keyword) {
    setState(() {
      mobilFiltered = semuaMobil.where((item) {
        return item["nama"].toString().toLowerCase().contains(
          keyword.toLowerCase(),
        );
      }).toList();
    });
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

                const SizedBox(height: 10),

                // SEARCH
                SizedBox(
                  height: 40,

                  child: TextField(
                    onChanged: searchMobil,

                    style: const TextStyle(color: Colors.white),

                    decoration: InputDecoration(
                      hintText: "Cari Mobil...",

                      hintStyle: const TextStyle(color: Colors.white70),

                      prefixIcon: const Icon(Icons.search, color: Colors.white),

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),

                        borderSide: const BorderSide(color: Colors.white),
                      ),

                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),

                        borderSide: const BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                Expanded(
                  child: mobilFiltered.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                      : GridView.builder(
                          itemCount: mobilFiltered.length,

                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.78,
                              ),

                          itemBuilder: (context, index) {
                            final item = mobilFiltered[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        DetailKendaraanPage(kendaraan: item),
                                  ),
                                );
                              },

                              child: Container(
                                padding: const EdgeInsets.all(8),

                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),

                                        child: Image.network(
                                          "https://opet-rent.web.id/storage/${item["gambar"]}",

                                          width: double.infinity,

                                          fit: BoxFit.cover,

                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Container(
                                                  color: Colors.grey.shade300,

                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.image_not_supported,
                                                    ),
                                                  ),
                                                );
                                              },
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 6),

                                    Text(
                                      item["nama"],

                                      maxLines: 2,

                                      overflow: TextOverflow.ellipsis,

                                      style: const TextStyle(
                                        color: Color(0xFF0A6DD9),

                                        fontWeight: FontWeight.bold,

                                        fontSize: 12,
                                      ),
                                    ),

                                    const SizedBox(height: 2),

                                    Text(
                                      "Rp ${double.parse(item["harga_sewa"]).toInt()}/hari",

                                      style: const TextStyle(
                                        color: Colors.grey,

                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
