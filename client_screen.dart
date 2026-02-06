import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ClientScreen extends StatefulWidget {
  const ClientScreen({Key? key}) : super(key: key);

  @override
  State<ClientScreen> createState() => _ClientScreenState();
}

class _ClientScreenState extends State<ClientScreen> {
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    if (user == null) return Center(child: Text("تسجيل الدخول مطلوب"));

    return Scaffold(
      appBar: AppBar(title: Text("صفحة العميل")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("clientUID", isEqualTo: user!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final orders = snapshot.data!.docs;

          if (orders.isEmpty) return Center(child: Text("لا توجد طلبات حالياً"));

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              final isVIP = order['isVIP'] ?? false;

              return Card(
                child: ListTile(
                  title: Text("طلب #${order.id} ${isVIP ? '[VIP]' : ''}"),
                  subtitle: Text("الحالة: ${order['status']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.star_rate),
                    onPressed: () {
                      Navigator.pushNamed(context, '/rateOrder', arguments: order.id);
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
