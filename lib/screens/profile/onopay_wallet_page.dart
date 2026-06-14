import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'topup_page.dart';
import 'scan_qr_page.dart';
import '../../services/onopay_service.dart';

class OnoPayWalletPage extends StatefulWidget {
  const OnoPayWalletPage({super.key});

  @override
  State<OnoPayWalletPage> createState() => _OnoPayWalletPageState();
}

class _OnoPayWalletPageState extends State<OnoPayWalletPage> {
  String? phoneNumber;
  String namaOnoPay = "-";
  String saldo = "Rp 0";

  bool isLoading = true;

  final rupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  @override
  void initState() {
    super.initState();
    loadOnoPay();
  }

  Future<void> loadOnoPay() async {
    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id");

    if (userId == null) {
      setState(() => isLoading = false);
      return;
    }

    final phone = prefs.getString("onopay_phone_$userId");

    if (phone == null) {
      setState(() => isLoading = false);
      return;
    }

    phoneNumber = phone;

    await loadBalance();
  }

  Future<void> loadBalance() async {
    if (phoneNumber == null) return;

    try {
      final result = await OnoPayService.checkBalance(phoneNumber!);

      if (result["success"] == true) {
        final data = result["data"];

        setState(() {
          namaOnoPay = data["name"] ?? "-";

          saldo = rupiah.format(data["balance"] ?? 0);

          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (_) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> connectOnoPay() async {
    final controller = TextEditingController();

    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
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
                  child: Icon(
                    Icons.account_balance_wallet,
                    size: 35,
                    color: Color(0xFF0A6DD9),
                  ),
                ),

                const SizedBox(height: 15),

                const Text(
                  "Hubungkan OnoPay",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Masukkan nomor yang terdaftar di akun OnoPay",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: "08xxxxxxxxxx",
                    prefixIcon: const Icon(Icons.phone),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

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
                      Navigator.pop(context, controller.text);
                    },
                    child: const Text(
                      "Hubungkan",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );

    if (result == null || result.trim().isEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    final check = await OnoPayService.checkUser(result);

    if (check["success"] != true) {
      setState(() {
        isLoading = false;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nomor OnoPay tidak ditemukan")),
      );

      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final userId = prefs.getInt("user_id");

    if (userId != null) {
      await prefs.setString("onopay_phone_$userId", result);
    }

    phoneNumber = result;

    await loadBalance();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Berhasil terhubung ke OnoPay")),
    );
  }

  Future<void> disconnectOnoPay() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.link_off,
                    color: Colors.red,
                    size: 38,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Putuskan OnoPay",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Akun OnoPay akan dilepaskan dari aplikasi OPET. Anda dapat menghubungkannya kembali kapan saja.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, height: 1.5),
                ),

                const SizedBox(height: 25),

                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text("Batal"),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          minimumSize: const Size(0, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Putuskan",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );

    if (confirm != true) return;

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt("user_id");

    if (userId != null) {
      await prefs.remove("onopay_phone_$userId");
    }

    setState(() {
      phoneNumber = null;
      namaOnoPay = "-";
      saldo = "Rp 0";
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Akun OnoPay berhasil diputuskan")),
    );
  }

  Widget buildWalletCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A6DD9), Color(0xFF4DB8FF)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 12),
        ],
      ),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.account_balance_wallet, color: Colors.white),
              SizedBox(width: 8),
              Text(
                "OnoPay Wallet",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Text(
            saldo,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          Text(
            namaOnoPay,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            phoneNumber ?? "-",
            style: const TextStyle(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget buildActionButton(IconData icon, String title, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 35, color: const Color(0xFF0A6DD9)),
              const SizedBox(height: 10),
              Text(title),
            ],
          ),
        ),
      ),
    );
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
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.all(16),
                  child: phoneNumber == null
                      ? Center(
                          child: ElevatedButton.icon(
                            onPressed: connectOnoPay,
                            icon: const Icon(Icons.link),
                            label: const Text("Hubungkan OnoPay"),
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                                const Text(
                                  "OnoPay Wallet",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 25),

                            buildWalletCard(),

                            const SizedBox(height: 25),

                            Row(
                              children: [
                                buildActionButton(
                                  Icons.add_card,
                                  "Top Up",
                                  () async {
                                    final refresh = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => TopUpPage(
                                          phoneNumber: phoneNumber!,
                                        ),
                                      ),
                                    );

                                    if (refresh == true) {
                                      loadBalance();
                                    }
                                  },
                                ),

                                const SizedBox(width: 15),

                                buildActionButton(
                                  Icons.qr_code_scanner,
                                  "Scan QR",
                                  () async {
                                    final refresh = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ScanQrPage(
                                          phoneNumber: phoneNumber!,
                                        ),
                                      ),
                                    );

                                    if (refresh == true) {
                                      loadBalance();
                                    }
                                  },
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Column(
                                children: [
                                  const CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Color(0xFFFFEBEE),
                                    child: Icon(
                                      Icons.link_off,
                                      color: Colors.red,
                                      size: 35,
                                    ),
                                  ),

                                  const SizedBox(height: 18),

                                  const Text(
                                    "Putuskan OnoPay",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 12),

                                  const Text(
                                    "Akun OnoPay akan dilepaskan dari aplikasi OPET. Anda dapat menghubungkannya kembali kapan saja.",
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 20),

                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: disconnectOnoPay,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                      ),
                                      child: const Text(
                                        "Putuskan OnoPay",
                                        style: TextStyle(color: Colors.white),
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
    );
  }
}
