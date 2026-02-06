import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({Key? key}) : super(key: key);

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  final DatabaseReference ordersRef = FirebaseDatabase.instance.ref('orders');
  final User? user = FirebaseAuth.instance.currentUser;

  List<Map<dynamic, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() {
    if (user == null) return;
    ordersRef.orderByChild('rider_id').equalTo(user!.uid).onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          orders = data.entries.map((e) => {'id': e.key, ...e.value as Map}).toList();
        });
      } else {
        setState(() {
          orders = [];
        });
      }
    });
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  Widget orderCard(Map<dynamic, dynamic> order) {
    bool isVIP = order['vip'] ?? false;
    bool sharePhone = order['sharePhone'] ?? false;
    String clientPhone = sharePhone ? (order['clientPhone'] ?? "غير متوفر") : "مخفي";

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        leading: isVIP ? const Icon(Icons.star, color: Colors.amber) : const Icon(Icons.shopping_bag),
        title: Text('طلب رقم: ${order['id']}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الحالة: ${order['status'] ?? "في الانتظار"}'),
            Text('رقم العميل: $clientPhone'),
            if (isVIP) const Text('⚡ VIP', style: TextStyle(color: Colors.red)),
          ],
        ),
        trailing: Text('السعر: ${order['total'] ?? "0"} ج.م'),
        onTap: () {
          // ممكن تضيف هنا صفحة تفاصيل الطلب أو زر تقييم إذا status = delivered
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة المندوب"),
        backgroundColor: Colors.yellow[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "الطلبات الحالية",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: orders.isEmpty
                  ? const Center(
                      child: Text(
                        "لا توجد طلبات حالياً",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        return orderCard(orders[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
