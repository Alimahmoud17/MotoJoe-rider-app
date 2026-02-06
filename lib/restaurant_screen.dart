import 'package:flutter/material.dart';

class RestaurantScreen extends StatefulWidget {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantScreen> createState() => _RestaurantScreenState();
}

class _RestaurantScreenState extends State<RestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة المطعم'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'مرحبًا بك في لوحة التحكم الخاصة بالمطعم',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // مثال: اضافة طلب جديد أو عرض الطلبات
              },
              child: const Text('عرض الطلبات'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // مثال: تحديث الحالة أو إعدادات المطعم
              },
              child: const Text('إعدادات المطعم'),
            ),
          ],
        ),
      ),
    );
  }
}
