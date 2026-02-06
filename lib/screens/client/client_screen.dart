import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final DatabaseReference ordersRef =
      FirebaseDatabase.instance.ref('orders'); // جدول الطلبات
  final User? user = FirebaseAuth.instance.currentUser;
  List<Map<dynamic, dynamic>> orders = [];

  @override
  void initState() {
    super.initState();
    fetchالطلبات();
  }

  void fetchالطلبات() {
    if (user == null) return;
    ordersRef
        .orderByChild('client_id')
        .equalTo(user!.uid)
        .onValue
        .listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        setState(() {
          orders = data.entries
              .map((e) => {'id': e.key, ...e.value as Map})
              .toList();
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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ListTile(
        title: Text('طلب رقم: ${order['id']}'),
        subtitle: Text('الحالة: ${order['status'] ?? "في الانتظار"}'),
        trailing: Text('السعر: ${order['total'] ?? "0"} ج.م'),
        onTap: () {
          // ممكن تضيف هنا صفحة تفاصيل الطلب
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('صفحة العميل'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      body: orders.isEmpty
          ? const Center(child: Text('لا يوجد طلبات حالياً'))
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return orderCard(orders[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // هنا ممكن تضيف وظيفة طلب جديد
        },
        child: const Icon(Icons.add),
        tooltip: 'طلب جديد',
      ),
    );
  }
}
