import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  bool isLoading = false;

  Future<void> createVIPOrder() async {
    setState(() => isLoading = true);

    Map<String, dynamic> vipOrder = {
      "details": "طلب VIP سريع",
      "lat": 0.0,
      "lng": 0.0,
      "phone": "",
      "showPhone": false,
      "isVIP": true,
      "vipFee": 10.0,
      "status": "waiting",
      "createdAt": DateTime.now(),
    };

    try {
      await FirebaseFirestore.instance.collection("orders").add(vipOrder);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم إنشاء طلب VIP بنجاح!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("خطأ أثناء إنشاء الطلب: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("مرحبا!")),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber[700],
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    ),
                    onPressed: createVIPOrder,
                    child: const Text(
                      "طلب VIP",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: const Text("تسجيل / تسجيل دخول"),
                  ),
                ],
              ),
      ),
    );
  }
}
