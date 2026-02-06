import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  // بيانات المطعم (مثال)
  String restaurantName = "اسم المطعم";
  String restaurantPhone = "01000000000";
  List<String> orders = []; // هتكون هنا الطلبات

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("لوحة المطعم"),
        backgroundColor: Colors.yellow[800],
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // كود تسجيل الخروج
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
            // بطاقة بيانات المطعم
            Card(
              color: Colors.grey[200],
              child: ListTile(
                leading: const Icon(Icons.store, size: 40),
                title: Text(restaurantName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                subtitle: Text("رقم الهاتف: $restaurantPhone"),
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
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.shopping_bag),
                            title: Text("طلب #${orders[index]}"),
                            subtitle: const Text("تفاصيل الطلب هنا"),
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
