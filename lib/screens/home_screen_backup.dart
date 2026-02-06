import 'package:flutter/material.dart';
import 'package:get/get.dart';

class الرئيسيةScreen extends StatelessWidget {
  const الرئيسيةScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home_title'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.language),
            tooltip: 'change_language'.tr,
            onPressed: () {
              // تغيير اللغة عند الضغط
              if (Get.locale!.languageCode == 'ar') {
                Get.updateLocale(const Locale('en'));
              } else {
                Get.updateLocale(const Locale('ar'));
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'welcome'.tr,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: Text('start_order'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
