import 'package:flutter/material.dart';

class RiderScreen extends StatefulWidget {
  const RiderScreen({Key? key}) : super(key: key);

  @override
  State<RiderScreen> createState() => _RiderScreenState();
}

class _RiderScreenState extends State<RiderScreen> {
  // مثال بيانات المندوب
  String riderName = "اسم المندوب";
  String riderPhone = "01000000000";

  // قائمة الطلبات مع بيانات إضافية
  List<Map<String, dynamic>> orders = [
    {
      "id": "1001",
      "details": "تفاصيل الطلب هنا",
      "clientPhone": "01011112222",
      "sharePhone": true,
      "vip": true,
      "status": "delivering"
    },
    {
      "id": "1002",
      "details": "تفاصيل الطلب هنا",
      "clientPhone": "01033334444",
      "sharePhone": false,
      "vip": false,
      "status": "delivering"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة المندوب"),
        backgroundColor: Colors.yellow[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // بيانات المندوب
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: const Icon(Icons.person, size: 40),
                title: Text(riderName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("رقم الهاتف: $riderPhone"),
              ),
            ),
            const SizedBox(height: 20),
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
                        final order = orders[index];
                        return Card(
                          color: order['vip'] ? Colors.yellow[100] : Colors.white,
                          child: ListTile(
                            leading: const Icon(Icons.shopping_bag),
                            title: Row(
                              children: [
                                Text("طلب #${order['id']}"),
                                const SizedBox(width: 8),
                                if (order['vip'])
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text("VIP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                  ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(order['details']),
                                if (order['sharePhone'])
                                  Text("رقم العميل: ${order['clientPhone']}", style: const TextStyle(color: Colors.blue)),
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
    );
  }
}
